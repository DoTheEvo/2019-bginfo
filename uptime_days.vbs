Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")

Set colOS = objWMIService.ExecQuery("SELECT LastBootUpTime FROM Win32_OperatingSystem")

For Each objOS In colOS

    bootTime = objOS.LastBootUpTime

Next

bootDate = DateSerial(Left(bootTime,4), Mid(bootTime,5,2), Mid(bootTime,7,2)) + _
           TimeSerial(Mid(bootTime,9,2), Mid(bootTime,11,2), Mid(bootTime,13,2))

uptimeDays = Int(Now - bootDate)

Echo uptimeDays & " days"