# 2019-bginfo

Deploys preset bginfo that

* updates every 15 minutes
* updates on network change events
* ignores inactive network connections
* only shows ipv4 info

Should work well with [NetSetMan](https://www.netsetman.com)

bginfo v4.26 2018-10-12

![demonstration](https://i.imgur.com/WMzRu8f.png)

### Installation:

* run DEPLOY.BAT as administrator
* done

######what it does:

* copies the files in to `C:\ProgramData\bginfo`
* imports scheduled task that 
 runs `"%PROGRAMDATA%\bginfo\Bginfo64.exe"`  
 with parameter  
 `"%PROGRAMDATA%\bginfo\bginfo_preset.bgi" /timer:0 /nolicprompt /silent`
 * at log in
 * at 15 min intervals
 * 3 seconds after events 10000, 10001, 4004 coming from `Microsoft-Windows-NetworkProfile/Operational`
* runs the freshly created scheduled task

### Additiona info:

* a file called `bginfo_update_NOW.lnk` can be placed anywhere to run the bginfo scheduled task at demand
* editing scheduled task and running it as group "users" will run it for all
* to get network info from only active network interfaces custom wmi queries are used for dhcp, dns, mac address, type. For ip address a vbs script `active_ip4.vbs` is used and needs to be in the same folder as the `bginfo_preset.bgi`

![bginfo](https://i.imgur.com/YN9VQPI.png)
