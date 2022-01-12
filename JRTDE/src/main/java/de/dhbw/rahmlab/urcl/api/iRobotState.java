package de.dhbw.rahmlab.urcl.api;

import de.dhbw.rahmlab.urcl.impl.std.Vector3double;
import de.dhbw.rahmlab.urcl.impl.std.Vector6double;
import de.dhbw.rahmlab.urcl.impl.std.Vector6int32;
import de.dhbw.rahmlab.urcl.impl.std.Vector6uint32;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_bool;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_double;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_int32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_string;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_uint32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_uint64_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_uint8_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_vector3d_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_vector6d_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_vector6int32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.getData2_vector6uint32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_bool;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_double;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_int32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_string;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_uint32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_uint64_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_uint8_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_vector3d_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_vector6d_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_vector6int32_t;
import static de.dhbw.rahmlab.urcl.impl.urcl__rtde__data_package.setData2_vector6uint32_t;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @author Oliver Rettig (Oliver.Rettig@orat.de)
 */
public interface iRobotState {
    
    public java.util.Optional<Boolean> getBool(String name);
    public java.util.Optional<Short> getUInt8(String name);
    public java.util.Optional<Long> getUInt32(String name);
    public java.util.Optional<Long> getUInt64(String name);
    public java.util.Optional<Integer> getInt32(String name);
    public java.util.Optional<Double> getDouble(String name);
    
    
    // oder VecMath-API verwenden? dann habe ich halt hier eine Abhängigkeit zu diesem package!
    
    public Optional<List<Double>> getVector3d(String name);
    public Optional<List<Double>> getVector6d(String name);
    public Optional<List<Integer>> getVector6Int32(String name);
    public Optional<List<Long>> getVector6UInt32(String name) ;
    public java.util.Optional<String> getString(String name) ;
}
