```
{
:local queueName "CUAN - $leaseActMAC";
:if ($leaseBound = "1") do={
/queue simple add name=$queueName queue=default/default target=($leaseActIP . "/32") max-limit=10M/8M limit-at=1M/1M parent="2.Cuan-Cuan";
} else={
/queue simple remove $queueName
}
}

```
