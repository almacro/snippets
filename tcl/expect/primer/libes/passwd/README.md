# `passwd` example

Updated code for `passwd` example as seen in
  [Using expect to Automate System Administration Tasks](https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=821312) by Don Libes.
 
## Demo

```
# useradd scott
# expect script.exp scott tiger
spawn passwd scott
Enter new UNIX password: 
Retype new UNIX password: 
passwd: password updated successfully
```
