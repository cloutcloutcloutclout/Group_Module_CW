// Javascript for notifications


const ID = id => document.getElementById(id); //function to get the elements by their ID
let unread = 0; //count of unread streaks
const sync = new BroadcastChannel('notif_sync'); //allows notifications to sync between pages
let isPageTransitioning = false; //checks if the user is moving to another page

// getting the history of notifications
async function loadHistory() {
    if (typeof currentUserId === 'undefined' || !currentUserId) return;

    // variable to check if the user has pressed the thing that triggers a streak (the courses button)
    const justClicked = sessionStorage.getItem('checkStreakTrigger') === 'true';

    // if the streak has been triggered then there is a 0.3 second delay to allow the database to save the streak data
    if (justClicked) {
        await new Promise(resolve => setTimeout(resolve, 300));
        sessionStorage.removeItem('checkStreakTrigger'); //prevents the trigger from activating again in the day
    }

    try { //gets all notifications for the user and converts it into json
        const res = await fetch('/api/notifications/' + currentUserId + '/all');
        const data = await res.json();

        let popupTriggered = false;//ensures only 1 popup is shown when the notification is activated

        // Sorts the notification
        data.sort((a, b) => (b.id || 0) - (a.id || 0));

        data.forEach(n => {
            let showAsPopup = false;
            const isStreak = n.notificationType && n.notificationType.toLowerCase().includes('streak'); //checks if notification is a streak type

            // shows the popup on the Search page they have pressed the streak
            if (justClicked && !popupTriggered && n.read === false && isStreak) {
                showAsPopup = true;
                popupTriggered = true;
            }
            addNotiToUI(n, showAsPopup);
        });
    } catch (e) { console.error("History error", e); }
}

// handles the clicks
//elements for the bell and dropdown menu
const menu = ID('notificationInboxMenu');
const bell = ID('notificationBell');

if (bell) { //logic to show the notifications if the bell has been pressed3
    bell.onclick = (e) => {
        e.preventDefault(); e.stopPropagation();
        menu?.classList.toggle('show');
    };
}
//logic to manage the clicks within the notification box controller
document.addEventListener("click", (e) => {
    if (!e.target.closest('#notificationBoxContainer')) menu?.classList.remove('show');
    if (e.target.closest('.toast-close')) e.target.closest('.toast-notification').remove();
});

// manages the connection to the server
if (typeof currentUserId !== 'undefined' && currentUserId) {
    const sse = new EventSource('/api/notifications/stream/' + currentUserId);
    sse.onmessage = (e) => {
        const n = JSON.parse(e.data);
        const transitioning = isPageTransitioning || sessionStorage.getItem('checkStreakTrigger') === 'true';

        // blocks the toast if the user is currently leaving the page
        addNotiToUI(n, !transitioning);
        sync.postMessage({action: 'new', data: n});
    };
}

// building the HTML for the notification popup
function addNotiToUI(n, isNew) {
    const id = n.id || n.notificationID;
    const container = ID('notificationContainer');
    if (!container) return;

    if (isNew) {
        const uniqueToastId = 'toast-' + (id || Date.now()); //html to be used for the notifications
        container.insertAdjacentHTML('beforeend', `
            <div class="toast-notification" id="${uniqueToastId}" style="display:block !important; opacity:1 !important; visibility:visible !important;">
                <div class="toast-header">
                    <h5 class="toast-title"><i class="ph ph-bell-ringing" style="color:#FFBC0A;margin-right:5px;"></i>${n.heading}</h5>
                    <button class="toast-close" onclick="this.closest('.toast-notification').remove()"><i class="fa-solid fa-xmark"></i></button>
                </div>
                <p class="toast-body">${n.notificationMsg}</p>
            </div>
        `);
        setTimeout(() => { ID(uniqueToastId)?.remove(); }, 8000);//popup closes after 8 seconds
    }

    if (ID('inboxItems')) {
        if (ID('notification-' + id)) return;
        if (ID('emptyInboxMsg')) ID('emptyInboxMsg').style.display = 'none';
        ID('inboxItems').insertAdjacentHTML('afterbegin', `
            <div class="dropdown-item" id="notification-${id}" style="padding:10px; border-bottom:1px solid #eee; white-space:normal; position:relative;">
                <button onclick="deleteNoti(${id}, event)" style="position:absolute; right:10px; top:10px; background:none; border:none; color:#999; cursor:pointer;"><i class="fa-solid fa-xmark"></i></button>
                <strong style="font-size:14px; color:#333; display:block;">${n.heading}</strong>
                <small style="color:#666; display:block; margin-top:4px;">${n.notificationMsg}</small>
            </div>
        `);
        updateBadge(1);
    }
}

//synchronizes notifications between other tabs and updates them for all
sync.onmessage = (e) => {
    if (e.data.action === 'new') {
        addNotiToUI(e.data.data, false);
    } else if (e.data.action === 'delete') {
        ID('notification-' + e.data.id)?.remove();
        updateBadge(-1);
    } else if (e.data.action === 'clearAll') {
        // --- ADDED THIS CASE ---
        if (ID('inboxItems')) ID('inboxItems').innerHTML = '';
        unread = 0;
        updateBadge(0);
    }
};
//function to delete the notification
window.deleteNoti = (id, e) => {
    if (e) { e.stopPropagation(); e.preventDefault(); }
    fetch('/api/notifications/delete/' + id, { method: 'DELETE' }).then(res => {
        if (res.ok) { ID('notification-' + id)?.remove(); updateBadge(-1); sync.postMessage({ action: 'delete', id }); }
    });
};

function updateBadge(change) {
    unread = Math.max(0, unread + change);

    // Update the red circle on the bell
    if (ID('notificationBadge')) {
        ID('notificationBadge').innerText = unread;
        ID('notificationBadge').style.display = unread > 0 ? 'inline-block' : 'none';
    }

    // logic to only have the clear all button if there are notifications
    if (ID('clearAllNotisBtn')) {
        ID('clearAllNotisBtn').style.display = unread > 0 ? 'block' : 'none';
    }

    // logic to have the no new notifications if it is empty
    if (ID('emptyInboxMsg')) {
        ID('emptyInboxMsg').style.display = unread > 0 ? 'none' : 'block';
    }
}
//function to actually clear the notifications
window.clearAllNotifications = (e) => {
    if (e) { e.stopPropagation(); e.preventDefault(); }
    if (typeof currentUserId === 'undefined' || !currentUserId) return;

    fetch('/api/notifications/' + currentUserId + '/clear-all', {
        method: 'DELETE'
    }).then(response => {
        if (response.ok) {

            if (ID('inboxItems')) ID('inboxItems').innerHTML = '';


            unread = 0;
            updateBadge(0);

            sync.postMessage({action: 'clearAll'});
        }
    });
};
// function to listen to any form submission on the entire page which triggers the notification event
document.addEventListener('submit', function(e) {
    const form = e.target.closest('form[action*="streak/increment-courses"]');
    if (form) {
        isPageTransitioning = true;
        sessionStorage.setItem('checkStreakTrigger', 'true');
    }
});
//loads the history fetch when the script runs
loadHistory();
