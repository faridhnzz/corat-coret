{
:local queueName "WIFI - $leaseActMAC";
:if ($leaseBound = "1") do={
/queue simple add name=$queueName queue=default/default target=($leaseActIP . "/32") max-limit=5M/5M limit-at=1M/1M parent="A.WIFI-Public" comment=[/ip dhcp-server lease get [find where active-mac-address=$leaseActMAC && active-address=$leaseActIP] host-name];
} else={
/queue simple remove $queueName
}
}
