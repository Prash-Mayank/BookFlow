package com.bookflow.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 * Spring Security configuration for BookFlow.
 *
 * Route protection:
 *   /admin/**     → ADM role only
 *   /librarian/** → LIB role only
 *   /student/**   → STU role only
 *   /auth/**      → public (login, register)
 *   /public/**    → public (home, assets)
 */
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UserDetailsService userDetailsService;

    public SecurityConfig(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    // ---- Password Encoder ------------------------------------------

    @Bean
    public PasswordEncoder passwordEncoder() {
        // BCrypt with strength 12 — suitable for all roles
        // (Student uses strength 10 at registration time via custom method)
        return new BCryptPasswordEncoder(12);
    }

    // ---- Authentication Provider -----------------------------------

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    // ---- Security Filter Chain ------------------------------------

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .authenticationProvider(authenticationProvider())

                // ---- Route access rules --------------------------------
                .authorizeHttpRequests(auth -> auth
                        // Public resources
                        .requestMatchers(
                                "/",
                                "/home",
                                "/auth/login",
                                "/auth/register",
                                "/auth/forgot-password",
                                "/public/**",
                                "/static/**",
                                "/css/**",
                                "/js/**",
                                "/images/**",
                                "/favicon.ico"
                        ).permitAll()

                        // Role-specific routes
                        .requestMatchers("/admin/**").hasAuthority("ROLE_ADM")
                        .requestMatchers("/librarian/**").hasAnyAuthority("ROLE_LIB", "ROLE_ADM")
                        .requestMatchers("/student/**").hasAuthority("ROLE_STU")

                        // Any other request requires authentication
                        .anyRequest().authenticated()
                )

                // ---- Form Login ----------------------------------------
                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("systemId")
                        .passwordParameter("password")
                        .defaultSuccessUrl("/dashboard", true)
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )

                // ---- Logout --------------------------------------------
                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/auth/logout"))
                        .logoutSuccessUrl("/auth/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )

                // ---- Session Management --------------------------------
                .sessionManagement(session -> session
                        .maximumSessions(1)           // One active session per user
                        .expiredUrl("/auth/login?expired=true")
                )

        // ---- CSRF protection (enabled by default in Spring Security) ---
        // CSRF is ON for all forms — JSP pages include the CSRF token
        ;

        return http.build();
    }
}