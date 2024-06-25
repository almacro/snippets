fn main() {
    let test1 = "We need more space.";
    assert_eq!(trim_spaces(test1), "We need more space.");
    let test2 = "   There's space in front.";
    assert_eq!(trim_spaces(test2), "There's space in front.");
    let test3 = "There's space to the rear. ";
    assert_eq!(trim_spaces(test3), "There's space to the rear.");
    let test4 = "  We're surrounded by space!     ";
    assert_eq!(trim_spaces(test4), "We're surrounded by space!");
    let test5 = "     ";
    assert_eq!(trim_spaces(test5), "");
    let test6 = "";
    assert_eq!(trim_spaces(test6), "");
    let test7 = " 🚀 ";
    assert_eq!(trim_spaces(test7), "🚀");
    println!("Test passed!");
}

// my solution
fn trim_spaces(s: &str) -> &str {
    let bytes = s.as_bytes();
    let length = bytes.len();
    if length == 0 { return ""; }

    let mut front: usize = 0;
    let mut rear: usize = length;
    while bytes[front] == b' ' {
        front += 1;
        if front >= length { return ""; }
    }
    while bytes[rear-1] == b' ' {
        rear -= 1;
    }
    &s[front..rear]
}

/* instructor solution
fn trim_spaces(s: &str) -> &str {
    // locate the first non-space character
    let mut start = 0;
    for (index, character) in s.chars().enumerate() {
        if character != ' ' {
            start = index;
            break;
        }
    }

    // search in reverse to locate the last non-space character
    let mut end = 0;
    for (index, character) in s.chars().rev().enumerate() {
        if character != ' ' {
            end = s.len() - index;
            break;
        }
    }

    &s[start..end]
}
*/