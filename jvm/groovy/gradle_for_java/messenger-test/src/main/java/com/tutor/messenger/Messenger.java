package com.tutor.messenger;

public class Messenger {
    public String createHelloMessage(String word, String language) {
        if (word == null || word.equals("")) {
            throw new IllegalArgumentException("Provided word may not be null or an empty string");
        }

        String prefix = "";

        switch(language) {
            case "english": prefix = "Hello";
                            break;
            case "spanish": prefix = "Hola";
                            break;
            case "german": prefix = "Hallo";
                           break;
            default: throw new IllegalArgumentException("Unsupported language: " + language);
        }

        return prefix + " " + word;
    }
}
