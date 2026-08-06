# 📒 Memory Management options
    Enable-MMAgent -ApplicationLaunchPrefetching
    Enable-MMAgent -ApplicationPreLaunch
    Enable-MMAgent -MemoryCompression # Like Linux's ZRAM/ZSwap and MacOS's WKdm
    Enable-MMAgent -OperationAPI
    Enable-MMAgent -PageCombining
    Set-MMAgent -MaxOperationAPIFiles 8192
