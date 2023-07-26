package de.dhbw.rahmlab.urcl.api;

/**
 * @author Oliver
 */
public class Notifier extends de.dhbw.rahmlab.urcl.impl.urcl.comm.Notifier {

    public Notifier() {
        super();
    }

    @Override
    public void started(String name) {
        System.out.println("Notifier.started: " + name);
    }

    @Override
    public void stopped(String name) {
        System.out.println("Notifier.stopped: " + name);
    }

    @Override
    public synchronized void delete() {
        super.delete();
    }
}
