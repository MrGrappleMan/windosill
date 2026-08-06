# Power Configuration - adjusted for energy efficiency bias

# Fast startup - reduce boot time, cache kernel files to dump directly to RAM
    powercfg /H ON

# Screen sleeps after 3 min
    powercfg /Change monitor-timeout-ac 3
    powercfg /Change monitor-timeout-dc 3

# Disk sleeps after 1 min, SSD only system assumed. Harmful for HDDs due to spin-down and thus, wear.
# Saves energy.
    powercfg /Change disk-timeout-ac 20 # If the device is a NAS or a file or disk recovery station dealing w/ HDDs, set this to 0.
    powercfg /Change disk-timeout-dc 1

# Sleep faster, prefer to use caffeine if sitting for a long time
# Or get a fingerprint reader
    powercfg /Change standby-timeout-ac 5 # Sleep after 5 min on AC
    powercfg /Change standby-timeout-dc 5 # Sleep after 5 min on battery

# Hibernate
    # Avoid hibernation on AC to preserve disk lifespan
    # Use hibernation only for critical situations, like power outages, reducing battery drain, etc.
    powercfg /Change hibernate-timeout-ac 0 # Never hibernate on AC
    powercfg /Change hibernate-timeout-dc 360 # Hibernate after 3 hours on battery

# Power Plan
#powercfg.exe -import "!cd!\powerplan.pow">nul
