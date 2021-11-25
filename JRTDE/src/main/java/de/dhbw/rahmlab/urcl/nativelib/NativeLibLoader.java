package de.dhbw.rahmlab.urcl.nativelib;

import de.dhbw.rahmlab.urcl.impl.urclSwigJNI;

/**
 * @author fabian
 */
public class NativeLibLoader {

    private static boolean isLoaded = false;

    public static void load() {
        if (!isLoaded) {
            loadActually();
            isLoaded = true;
        }
    }

    private static void loadActually() {
        try {
            de.dhbw.rahmlab.nativelibloader.api.NativeLibLoader.init(true);
            de.dhbw.rahmlab.nativelibloader.api.NativeLibLoader nativeLibLoader = de.dhbw.rahmlab.nativelibloader.api.NativeLibLoader.getInstance();
            nativeLibLoader.load(urclSwigJNI.class);
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
