package com.tutor.messenger;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class MessengerTest {
    private final Messenger messenger = new Messenger();

    @Test
    void failsForNullName() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            messenger.createHelloMessage(null, "english");
        });
        assertEquals("Provided word may not be null or an empty string", exception.getMessage());
    }

    @Test
    void failsForEmptyName() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            messenger.createHelloMessage("", "english");
        });
        assertEquals("Provided word may not be null or an empty string", exception.getMessage());
    }

    @Test
    void canCreateHelloMessageInEnglish() {
        assertEquals("Hello Ben", messenger.createHelloMessage("Ben", "english"));
    }

    @Test
    void canCreateHelloMessageInSpanish() {
        assertEquals("Hola John", messenger.createHelloMessage("John", "spanish"));
    }

    @Test
    void canCreateHelloMessageInGerman() {
        assertEquals("Hallo Mary", messenger.createHelloMessage("Mary", "german"));
    }

    @Test
    void failsForUnsupportedLanguage() {
        IllegalArgumentException exception = assertThrows(IllegalArgumentException.class, () -> {
            messenger.createHelloMessage("Jason", "french");
        });
        assertEquals("Unsupported language: french", exception.getMessage());
    }
}
