package de.dhbw.rahmlab.urcl.api;

/**
 * @author Oliver Rettig (Oliver.Rettig@orat.de)
 */
public class VersionInformation {
    
    private final long major;
    private final long minor;
    private final long bugFix;
    private final long build;
    
    VersionInformation(long major, long minor, long bugFix, long build){
        this.major = major;
        this.minor = minor;
        this.bugFix = bugFix;
        this.build = build;
    }
    public long getMajor(){
        return major;
    }
    public long getMinor(){
        return minor;
    }
    public long getBugfix(){
        return bugFix;
    }
    public long getBuild(){
        return build;
    }
}
