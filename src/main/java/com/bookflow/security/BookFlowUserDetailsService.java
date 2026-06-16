package com.bookflow.security;

import com.bookflow.model.User;
import com.bookflow.repository.UserRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class BookFlowUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public BookFlowUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String systemId) throws UsernameNotFoundException {
        User user = userRepository.findById(systemId)
                .orElseThrow(() -> new UsernameNotFoundException("No account found for System ID: " + systemId));

        return new BookFlowUserDetails(user);
    }
}