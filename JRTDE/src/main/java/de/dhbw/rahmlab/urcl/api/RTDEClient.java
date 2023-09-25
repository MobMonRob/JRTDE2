package de.dhbw.rahmlab.urcl.api;

//import de.dhbw.rahmlab.urcl.impl.DummyNotifier;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.DataPackage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

/**
 * @author Oliver Rettig (Oliver.Rettig@orat.de)
 */
public class RTDEClient {
    
    private de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient client;
    private boolean started = false;
    private final Notifier notifier;
    private final List<String> outputs;
    private final List<String> inputs;
    
    /**
     * Sets up RTDE communication with the robot. The handshake includes negotiation of the<br>
     * used protocol version and setting of input and output recipes.
     */
    public RTDEClient(List<String> outputs, List<String> inputs, String ip, Notifier notifier) throws IOException {
        this.notifier = notifier;
        this.inputs = inputs;
        this.outputs = outputs;
        client = new de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient(ip, notifier, 
                setOutputRecipe(outputs).getAbsolutePath(), setInputRecipe(inputs).getAbsolutePath());
    }
    
    /**
     * TODO unklar, ob hier die "maximale" version gemeint ist oder die Version,
     * die mit dem robot ausgehandelt wurde zu verwenden. Wenn letzteres zutrifft
     * dann kann die Methode vermutlich erst nach dem Aufruf von init() aufgerufen 
     * werden also erst nachdem die version auch ausgehandelt wurde
     * 
     * @return version
     */
    public VersionInformation getVersion(){
        de.dhbw.rahmlab.urcl.impl.urcl.VersionInformation versionInformation = client.getVersion();
        return new VersionInformation(versionInformation.getMajor(), versionInformation.getMinor(), 
                versionInformation.getBuild(), versionInformation.getBugfix());
    }
    
   /**
    * Getter for the frequency the robot will publish RTDE data packages with.<br>
    * <br>
    * @return The used frequency
    */
    public double getMaxFrequency() {
        return client.getMaxFrequency();
    }
    
    /**
     * Sets up RTDE communication with the robot. The handshake includes negotiation of the<br>
     * used protocol version and setting of input and output recipes.<br>
     * <br>
     * @return Success of the handshake
     */
    public boolean init(){
        return client.init();
    }
    
    /**
     * Triggers the robot to start sending RTDE data packages in the negotiated format.<br>
     * <br>
     * @return Success of the requested start
     */
    public boolean start() {
        boolean result =  client.start();
        if (result) started = true;
        return result;
    }
    public void stop() throws IllegalStateException, IOException {
        if (started) {
            String ip = client.getIP();
            client.delete();
            client = new de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient(ip, notifier, 
                    setOutputRecipe(outputs).getAbsolutePath(), setInputRecipe(inputs).getAbsolutePath());
        } else {
            throw new IllegalStateException("Invocation of stop() before start() not allowed!");
        }
    }
    
    /**
     * Reads the pipeline to fetch the next data package (blocking api).<br>
     * <br>
     * Read latest RTDE package. This will block for timeout_in_ms, so the
     * robot will effectively be in charge of setting the frequency of this loop unless RTDE
     * communication doesn't work in which case the user will be notified.
     * In a real-world application this thread should be scheduled with real-time priority in order
     * to ensure that this is called in time.
     * <br>
     * @param timeout_in_ms Time to wait if no data package is currently in the queue<br>
     * <br>
     * @return Unique ptr to the package, if a package was fetched successfully, null otherwise
     */
    public RobotState receiveData(long timeout_in_ms){
        DataPackage result = client.getDataPackage(timeout_in_ms);
        if (result != null){
            return new RobotState(result);
        } else {
            return null;
        }
    }
    private File setOutputRecipe(List<String> outputs) throws IOException {
        File tempFile = File.createTempFile("rtde_output_recipe","txt");
        BufferedWriter bw = new BufferedWriter(new FileWriter(tempFile));
        for (String outputLabel: outputs){
            bw.write(outputLabel);
            bw.write("\n");
        }
        return tempFile;
    }
    private File setInputRecipe(List<String> inputs) throws IOException {
        File tempFile = File.createTempFile("rtde_input_recipe","txt");
        BufferedWriter bw = new BufferedWriter(new FileWriter(tempFile));
        for (String inputLabel: inputs){
            bw.write(inputLabel);
            bw.write("\n");
        }
        return tempFile;
    }
}
