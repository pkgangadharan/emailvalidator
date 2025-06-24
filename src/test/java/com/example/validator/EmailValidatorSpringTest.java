package com.example.validator;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
public class EmailValidatorSpringTest {

    @Test
    void contextLoads() {
        assertTrue(true);
    }

    @Test
    void testValidEmailInContext() {
        assertTrue(EmailValidator.isFullyValidEmail("user@gmail.com"));
    }
}
