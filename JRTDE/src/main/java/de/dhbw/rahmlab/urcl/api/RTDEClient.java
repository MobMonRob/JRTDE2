package de.dhbw.rahmlab.urcl.api;

import de.dhbw.rahmlab.urcl.api.impl.DummyNotifier;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.DataPackage;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Oliver Rettig (Oliver.Rettig@orat.de)
 */
public class RTDEClient {
    
    private de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient client;
    
    public RTDEClient(List<String> outputs, List<String> inputs, String ip) throws IOException {
        client = new de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.RTDEClient(ip, new DummyNotifier(), 
                setOutputRecipe(outputs).getAbsolutePath(), setInputRecipe(inputs).getAbsolutePath());
    }
    
    public boolean init(){
        return client.init();
    }
    
    /**
     * Reads the pipeline to fetch the next data package (blocking api).<br>
     * <br>
     * @param timeout_in_ms Time to wait if no data package is currently in the queue<br>
     * <br>
     * @return Unique ptr to the package, if a package was fetched successfully, null otherwise
     */
    public RobotState receiveData(long timeout_in_ms){
        // Read latest RTDE package. This will block for timeout_in_ms, so the
        // robot will effectively be in charge of setting the frequency of this loop unless RTDE
        // communication doesn't work in which case the user will be notified.
        // In a real-world application this thread should be scheduled with real-time priority in order
        // to ensure that this is called in time.
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
