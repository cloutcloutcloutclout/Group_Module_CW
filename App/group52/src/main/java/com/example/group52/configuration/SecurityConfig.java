package com.example.group52.configuration;

import static org.springframework.security.config.Customizer.withDefaults;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.SecurityFilterChain;

import com.example.group52.service.Oauth2UserService;

import jakarta.servlet.DispatcherType;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    private final UserDetailsService userDetailsService;
    private final Oauth2UserService oauth2UserService;

    public SecurityConfig(UserDetailsService userDetailsService, Oauth2UserService oauth2UserService) {
        this.userDetailsService = userDetailsService;
        this.oauth2UserService = oauth2UserService;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .cors(withDefaults())
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(auth -> auth
                    .requestMatchers("/stats/ask").permitAll()
                    .requestMatchers("/stats/userstats").permitAll()
                    .requestMatchers("/", "/course.html", "/skillsbuild_simulator.html", "/return.html", "/session_status.html", "/courses/**").permitAll()
                    .requestMatchers("/sessions/ext-heartbeat", "/sessions/ext-close", "/sessions/ext-pause", "/sessions/ext-resume").permitAll()
                    .dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ERROR).permitAll()
                    .requestMatchers("/css/**", "/js/**", "/images/**", "/webjars/**").permitAll()
                    .requestMatchers("/h2-console", "/h2-console/**").hasRole("ADMIN")
                    .requestMatchers("/register", "/login", "/error", "/forgot-password").permitAll()
                    .requestMatchers("/admin/**").hasRole("ADMIN")
                    .requestMatchers("/user/**", "/welcome").hasAnyRole("USER", "ADMIN")
                    .requestMatchers("/profile/**").authenticated()
                    .requestMatchers("/api/**").authenticated()
                    .requestMatchers("/streak/**").authenticated()
                    .requestMatchers("/feedback/**").authenticated()
                    .requestMatchers("/courses/**").authenticated()
                    .anyRequest().authenticated()
            )
            .exceptionHandling(e -> e.accessDeniedPage("/denied"))
            .formLogin(form -> form
                    .loginPage("/login")
                    .loginProcessingUrl("/login")
                    .defaultSuccessUrl("/success-login", true)
                    .permitAll()
            )
            .oauth2Login(oauth2 -> oauth2
                .loginPage("/login")
                .defaultSuccessUrl("/success-login", true)
                    .defaultSuccessUrl("/profile", true)
                    .userInfoEndpoint(userInfo -> userInfo.userService(oauth2UserService))

            )
            .logout(logout -> logout
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/login?logout")
                    .deleteCookies("JSESSIONID")
                    .permitAll()
            )
            .headers(headers -> headers.frameOptions(frame -> frame.sameOrigin()))
            .userDetailsService(userDetailsService);
        return http.build();
    }

}
