package in.ind.pkg.utils;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import static org.junit.jupiter.api.Assertions.assertTrue;

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
