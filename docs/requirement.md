REQ-12  Reserve a room
The system shall let a guest reserve a room only after
the guest enters valid details.
 
AC1  Given the booking form is open
     When the guest taps Reserve with every field empty
     Then errors appear for name, phone, check-in date, and policy
AC2  Given a phone number with fewer than 10 digits
     When the guest taps Reserve
     Then the message "Use 10 or 11 digits, numbers only" appears
AC3  Given a name with fewer than 3 characters
     When the guest taps Reserve
     Then the message "Name must have at least 3 characters" appears
AC4  Given valid name, phone, check-in date, and accepted policy
     When the guest taps Reserve
     Then the Choose Your Room screen opens
AC5  Given an error under the name field
     When the guest types a valid name
     Then the error disappears
