Network Defense System: 

I built a network defense system which includes three components : 
  An Intrusion Detection System, 
  A HoneyPot (a vulnerable system) and 
  A Metasploit framework (to simulate an attacker machine).

I installed Snort, an open source IDS on the Raspberry Pi running Raspbian OS. I configured the IDS with the rules to detect malicious packets and trigger alerts. I installed Virtual Box VM on my computer and installed a Kali Linux VM vulnerable system which acts as HoneyPot to lure attacks. I installed the MetaSploit framework on another Kali Linux VM to simulate attacks on this network. I simulated SSH Brute Force Attacks, TCP Denial of Service Attacks from the attacker machine to attack the HoneyPot. The IDS detects and alerts the administrator of the attack details - location of the attack, IP address, type of the attack etc. Initial challenge was getting the same subnet IP address for the VMs. I had to study and understand the network modes of the VMs and set it to bridge mode. The hardest challenge was the IDS not receiving all the network packets because of the limitations on my router. After researching, I had to execute a firewall command on the HoneyPot to enable all the packets on the network. The whole project was so intense and exciting because of the extent of networking and security concepts that I had to learn and also the live packets and attacks I could see on the IDS.
