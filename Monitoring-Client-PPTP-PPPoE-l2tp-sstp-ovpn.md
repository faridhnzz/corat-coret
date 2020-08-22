Mikrotik

* On UP / Login
```
:local nama "$user";
:local bot "(Input Bot Telegram)";
:local chat "(Input ChatID Telegram)";
:local ips [/ppp active get [find name=$nama] address];
:local up [/ppp active get [find name=$nama] uptime];
:local caller [/ppp active get [find name=$nama] caller-id];
:local service [/ppp active get [find name=$nama] service];
:local profile [/ppp secret get [find name=$nama] profile];
:local active [/ppp active print count];
/tool fetch url="https://api.telegram.org/bot$bot/sendMessage?chat_id=$chat &text=LOGIN \E2\9C\94%0A---------------------------%0AUser : $user%0AIP Client : $ips%0ACaller ID : $caller%0AUptime : $up%0A---------------------------%0AService : $service %0AProfile : $profile%0ATotal Active : $active%0A" mode=http keep-result=no;
```

* On Down / Logout
```
:local nama "$user";
:local bot "(Input Bot Telegram)";
:local chat "(Input ChatID Telegram)";
:local service [/ppp secret get [find name=$nama] service];
:local local [/ppp secret get [find name=$nama] local];
:local remote [/ppp secret get [find name=$nama] remote];
:local profile [/ppp secret get [find name=$nama] profile];
:local last [/ppp secret get [find name=$nama] last];
/tool fetch url="https://api.telegram.org/bot$bot/sendMessage?chat_id=$chat&text=LOGOUT \E2\9D\8C%0A---------------------------%0AUser : $user%0AProfile : $profile%0AService : $service%0A---------------------------%0ALast Logout : $last%0A" mode=http keep-result=no;
```
