(function() {
    var toggle = document.getElementById('adminModeToggle');
    if (!toggle) return;
    var userLinks = document.querySelector('.user-sidebar-links');
    var adminLinks = document.querySelector('.admin-sidebar-links');
    if (sessionStorage.getItem('adminMode') === 'true') {
        userLinks.style.display = 'none';
        adminLinks.style.display = '';
        toggle.innerHTML = '<i class="ph ph-user"></i> User';
    }
    toggle.addEventListener('click', function(e) {
        e.preventDefault();
        var entering = adminLinks.style.display === 'none';
        userLinks.style.display = entering ? 'none' : '';
        adminLinks.style.display = entering ? '' : 'none';
        toggle.innerHTML = entering ? '<i class="ph ph-user"></i> User' : '<i class="ph ph-shield-check"></i> Admin';
        sessionStorage.setItem('adminMode', entering ? 'true' : 'false');
    });
})();
