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
@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final UserDetailsService userDetailsService;

    public SecurityConfig(UserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .authenticationProvider(authenticationProvider())

                .authorizeHttpRequests(auth -> auth
                        .dispatcherTypeMatchers(jakarta.servlet.DispatcherType.FORWARD, jakarta.servlet.DispatcherType.ERROR).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/home")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/login")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/login", "POST")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/register")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/register", "POST")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/forgot-password")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/forgot-password", "POST")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/reset-password")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/reset-password", "POST")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/test")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/auth/bare")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/public/**")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/static/**")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/css/**")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/js/**")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/images/**")).permitAll()
                        .requestMatchers(new AntPathRequestMatcher("/favicon.ico")).permitAll()

                        .requestMatchers(new AntPathRequestMatcher("/admin/**")).hasAuthority("ROLE_ADM")
                        .requestMatchers(new AntPathRequestMatcher("/librarian/**")).hasAnyAuthority("ROLE_LIB", "ROLE_ADM")
                        .requestMatchers(new AntPathRequestMatcher("/student/**")).hasAuthority("ROLE_STU")

                        .anyRequest().authenticated()
                )

                .formLogin(form -> form
                        .loginPage("/auth/login")
                        .loginProcessingUrl("/auth/login")
                        .usernameParameter("systemId")
                        .passwordParameter("password")
                        .defaultSuccessUrl("/dashboard", true)
                        .failureUrl("/auth/login?error=true")
                        .permitAll()
                )

                .logout(logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/auth/logout"))
                        .logoutSuccessUrl("/auth/login?logout=true")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                        .permitAll()
                )

                .sessionManagement(session -> session
                        .maximumSessions(1)
                        .expiredUrl("/auth/login?expired=true")
                );

        return http.build();
    }
}