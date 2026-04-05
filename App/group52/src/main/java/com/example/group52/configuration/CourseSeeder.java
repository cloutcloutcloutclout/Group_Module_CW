package com.example.group52.configuration;

import java.util.Arrays;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.example.group52.model.Course;
import com.example.group52.repository.CourseRepository;

@Configuration
public class CourseSeeder {

    @Bean
    CommandLineRunner seedCourses(CourseRepository courseRepository) {
        return args -> {
            if (courseRepository.count() == 0) {
                Course course1 = new Course();
                course1.setName("Introduction to Large Language Models");
                course1.setDescription("In this module, you'll explore the capabilities of large language models and their business applications. You'll learn about the different types of IBM Granite models and the unique features that make them ideal for enterprise use. You'll also discover how to craft effective prompts to guide these models and overcome common challenges in their use.");
                course1.setCategory("Artificial Intelligence");
                course1.setUrl("https://skills.yourlearning.ibm.com/activity/ALM-COURSE_4058915?ngo-id=0302");
                course1.setLanguages(Arrays.asList("English", "Arabic", "Brazilian Portuguese", "Indonesian", "Japanese", "Spanish"));
                course1.setEligibility("Eligible to registered learners");
                course1.setDurationMinutes(90);
                course1.setImage("/images/Introduction-to-Large-Language-Models.webp");
                courseRepository.save(course1);

                Course course2 = new Course();
                course2.setName("Level Up Cybersecurity with Generative AI");
                course2.setDescription("In this module, you'll explore features of generative AI used in cybersecurity. You'll discover how gen AI helps with cybersecurity incidents by enabling faster threat detection, better decision making, and automating time-consuming tasks. You'll also learn how gen AI handles specific cybersecurity problems in the healthcare, finance, and public sectors.");
                course2.setCategory("Cybersecurity");
                course2.setUrl("https://skills.yourlearning.ibm.com/activity/ALM-COURSE_3947352?ngo-id=0302");
                course2.setLanguages(Arrays.asList("English"));
                course2.setEligibility("Eligible to registered learners");
                course2.setDurationMinutes(90);
                course2.setImage("/images/Level-Up-Cybersecurity-with-Generative-AI.webp");
                courseRepository.save(course2);

                Course course3 = new Course();
                course3.setName("Build Your First Chatbot Using IBM watsonx");
                course3.setDescription("Learn to create conversational chatbots that understand natural language and fundamentals of NLP.");
                course3.setCategory("Artificial Intelligence");
                course3.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-510?ngo-id=0302");
                course3.setLanguages(Arrays.asList("English"));
                course3.setEligibility("Eligible to registered learners");
                course3.setDurationMinutes(60);
                course3.setImage("/images/Build-Your-First-Chatbot.jpeg");
                courseRepository.save(course3);

                Course course4 = new Course();
                course4.setName("Classifying Data Using IBM Granite");
                course4.setDescription("Explore generative AI in simplifying tasks involving classifying data using IBM Granite models.");
                course4.setCategory("Artificial Intelligence");
                course4.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-563?ngo-id=0302");
                course4.setLanguages(Arrays.asList("English"));
                course4.setEligibility("Eligible to registered learners");
                course4.setDurationMinutes(60);
                course4.setImage("/images/Classifying-Data-using-IBM-Granite.jpeg");
                courseRepository.save(course4);

                Course course5 = new Course();
                course5.setName("Explore Text to Speech Using IBM watson®");
                course5.setDescription("Introduces fundamentals of TTS technology and the role of generative AI in voice synthesis.");
                course5.setCategory("Artificial Intelligence");
                course5.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-507?ngo-id=0302");
                course5.setLanguages(Arrays.asList("English"));
                course5.setEligibility("Eligible to registered learners");
                course5.setDurationMinutes(60);
                course5.setImage("/images/Explore-Text-to-Speech-Using-IBM-watsonx.webp");
                courseRepository.save(course5);

                Course course6 = new Course();
                course6.setName("IBM Granite Models for Software Development");
                course6.setDescription("Discover how generative AI is rewriting code creation and troubleshooting rules.");
                course6.setCategory("Artificial Intelligence");
                course6.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-567?ngo-id=0302");
                course6.setLanguages(Arrays.asList("English"));
                course6.setEligibility("Eligible to registered learners");
                course6.setDurationMinutes(60);
                course6.setImage("/images/IBM-Granite-Models-for-Software-Development.webp");
                courseRepository.save(course6);

                Course course7 = new Course();
                course7.setName("Getting Started with Cybersecurity");
                course7.setDescription("Foundational understanding of cybersecurity elements, threats, and data privacy.");
                course7.setCategory("Cybersecurity");
                course7.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-C7EE7CC95370?ngo-id=0302");
                course7.setLanguages(Arrays.asList("English"));
                course7.setEligibility("Eligible to registered learners");
                course7.setDurationMinutes(180);
                course7.setImage("/images/Getting_Started_With_Cybersecurity_Badge.webp");
                courseRepository.save(course7);

                Course course8 = new Course();
                course8.setName("Cybersecurity Fundamentals");
                course8.setDescription("Understanding of cyber threat groups, social engineering, and risk management.");
                course8.setCategory("Cybersecurity");
                course8.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-4FB8400F05FC?ngo-id=0302");
                course8.setLanguages(Arrays.asList("English"));
                course8.setEligibility("Eligible to registered learners");
                course8.setDurationMinutes(450);
                course8.setImage("/images/Cybersecurity-Fundamentals.webp");
                courseRepository.save(course8);

                Course course9 = new Course();
                course9.setName("Enterprise Security in Practice");
                course9.setDescription("Concepts, methods, and tools related to the enterprise security domain.");
                course9.setCategory("Cybersecurity");
                course9.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-BBCABF0CF5B0?ngo-id=0302");
                course9.setLanguages(Arrays.asList("English"));
                course9.setEligibility("Eligible to registered learners");
                course9.setDurationMinutes(600);
                course9.setImage("/images/Enterprise-Security-in-Practice.webp");
                courseRepository.save(course9);

                Course course10 = new Course();
                course10.setName("Getting Started With Threat Intelligence and Hunting");
                course10.setDescription("Demonstrated domain knowledge in practices related to cyber threat hunting.");
                course10.setCategory("Cybersecurity");
                course10.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-D5ED0773935F?ngo-id=0302");
                course10.setLanguages(Arrays.asList("English"));
                course10.setEligibility("Eligible to registered learners");
                course10.setDurationMinutes(300);
                course10.setImage("/images/Getting-Started-with-Threat-Intelligence-and-Hunting.webp");
                courseRepository.save(course10);

                Course course11 = new Course();
                course11.setName("Getting Started with Data");
                course11.setDescription("Foundational understanding of data concepts, analytics process, and visualization.");
                course11.setCategory("Data Science");
                course11.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-14F2691E3A32?ngo-id=0302");
                course11.setLanguages(Arrays.asList("English"));
                course11.setEligibility("Eligible to registered learners");
                course11.setDurationMinutes(180);
                course11.setImage("/images/Getting_Started_With_Data_Badge.webp");
                courseRepository.save(course11);

                Course course12 = new Course();
                course12.setName("Data Fundamentals");
                course12.setDescription("Knowledge of data analytics concepts, methodologies, and the data ecosystem.");
                course12.setCategory("Data Science");
                course12.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-BC0FAEE8E439?ngo-id=0302");
                course12.setLanguages(Arrays.asList("English", "French"));
                course12.setEligibility("Eligible to registered learners");
                course12.setDurationMinutes(420);
                course12.setImage("/images/Data-Fundamentals.webp");
                courseRepository.save(course12);

                Course course13 = new Course();
                course13.setName("Enterprise Data Science in Practice");
                course13.setDescription("Hands-on labs and concepts related to real-world enterprise data science challenges.");
                course13.setCategory("Data Science");
                course13.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-0D62D9A52C35?ngo-id=0302");
                course13.setLanguages(Arrays.asList("English"));
                course13.setEligibility("Eligible to registered learners");
                course13.setDurationMinutes(600);
                course13.setImage("/images/Enterprise-Data-Science-in-Practice.webp");
                courseRepository.save(course13);

                Course course14 = new Course();
                course14.setName("Cloud Computing Fundamentals");
                course14.setDescription("Knowledge of cloud services, deployment models, virtualization, and security.");
                course14.setCategory("Cloud Computing");
                course14.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-2EC3A305F2C3?ngo-id=0302");
                course14.setLanguages(Arrays.asList("English"));
                course14.setEligibility("Eligible to registered learners");
                course14.setDurationMinutes(600);
                course14.setImage("/images/Cloud-Computing-Fundamentals.png");
                courseRepository.save(course14);

                Course course15 = new Course();
                course15.setName("Developing Cloud-Native Applications");
                course15.setDescription("Learn the essentials of modern web development using microservices and containers.");
                course15.setCategory("Web Development");
                course15.setUrl("https://skills.yourlearning.ibm.com/activity/URL-4C2C1AC7B6CB");
                course15.setLanguages(Arrays.asList("English"));
                course15.setEligibility("Eligible to registered learners");
                course15.setDurationMinutes(480);
                course15.setImage("/images/web-dev-cloud-native.png");
                courseRepository.save(course15);

                Course course16 = new Course();
                course16.setName("Leadership and followership");
                course16.setDescription("Master the soft skills required to lead diverse teams in a remote-first world.");
                course16.setCategory("Professional Skills");
                course16.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-456");
                course16.setLanguages(Arrays.asList("English", "Spanish"));
                course16.setEligibility("Eligible to registered learners");
                course16.setDurationMinutes(1200);
                course16.setImage("/images/ou.png");
                courseRepository.save(course16);

                Course course17 = new Course();
                course17.setName("Fundamentals of Sustainability and Technology");
                course17.setDescription("Gain foundational skills for the green economy by exploring sustainability science and its practical applications");
                course17.setCategory("Sustainability");
                course17.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-BE0E24A0BA5C");
                course17.setLanguages(Arrays.asList("English"));
                course17.setEligibility("Eligible to registered learners");
                course17.setDurationMinutes(180);
                course17.setImage("/images/sustainability-tech.png");
                courseRepository.save(course17);

                Course course18 = new Course();
                course18.setName("Job Application Essentials");
                course18.setDescription("Kickstart your career by building a professional brand and a personalized career path.");
                course18.setCategory("Job Readiness");
                course18.setUrl("https://skills.yourlearning.ibm.com/activity/PLAN-CC4C7655BD0D");
                course18.setLanguages(Arrays.asList("English"));
                course18.setEligibility("Eligible to registered learners");
                course18.setDurationMinutes(90);
                course18.setImage("/images/job-application.png");
                courseRepository.save(course18);

                Course course19 = new Course();
                course19.setName("Quantum Enigmas");
                course19.setDescription("prepare for a deeper understanding of quantum computing principles and techniques through the exploration and solving of intriguing quantum enigmas.");
                course19.setCategory("Quantum Computing");
                course19.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-202");
                course19.setLanguages(Arrays.asList("English"));
                course19.setEligibility("Eligible to registered learners");
                course19.setDurationMinutes(300);
                course19.setImage("/images/quantum-enigma.png");
                courseRepository.save(course19);

                Course course20 = new Course();
                course20.setName("Introduction to IBM z/OS | IBM Training");
                course20.setDescription("Discover why mainframes still power the global economy and learn basic z/OS navigation.");
                course20.setCategory("Mainframe");
                course20.setUrl("https://skills.yourlearning.ibm.com/activity/MDL-303");
                course20.setLanguages(Arrays.asList("English"));
                course20.setEligibility("Eligible to registered learners");
                course20.setDurationMinutes(540);
                course20.setImage("/images/mainframe-zos.png");
                courseRepository.save(course20);

                System.out.println("Courses seeded: 20 courses created.");
            }
        };
    }
}
