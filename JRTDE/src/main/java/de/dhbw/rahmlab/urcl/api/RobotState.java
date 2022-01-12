package de.dhbw.rahmlab.urcl.api;

import de.dhbw.rahmlab.urcl.impl.std.Vector3double;
import de.dhbw.rahmlab.urcl.impl.std.Vector6double;
import de.dhbw.rahmlab.urcl.impl.std.Vector6int32;
import de.dhbw.rahmlab.urcl.impl.std.Vector6uint32;
import de.dhbw.rahmlab.urcl.impl.urcl.rtde_interface.DataPackage;
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

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 * @author Oliver Rettig (Oliver.Rettig@orat.de)
 */
public class RobotState implements iRobotState {

    private final DataPackage dpk;
    
    RobotState(DataPackage dpk){
        this.dpk = dpk;
    }
    
    @Override
    public java.util.Optional<Boolean> getBool(String name) {
        return getData2_bool(dpk, name);
    }
    @Override
    public java.util.Optional<Short> getUInt8(String name) {
        return getData2_uint8_t(dpk, name);
    }
    @Override
    public java.util.Optional<Long> getUInt32(String name) {
        return getData2_uint32_t(dpk, name);
    }
    @Override
    public java.util.Optional<Long> getUInt64(String name) {
        return getData2_uint64_t(dpk, name);
    }
    @Override
    public java.util.Optional<Integer> getInt32(String name) {
        return getData2_int32_t(dpk, name);
    }
    @Override
    public java.util.Optional<Double> getDouble(String name) {
        return getData2_double(dpk, name);
    }
    
    
    // oder VecMath-API verwenden? dann habe ich halt hier eine Abhängigkeit zu diesem package!
    
    @Override
    public Optional<List<Double>> getVector3d(String name) {
        java.util.Optional<de.dhbw.rahmlab.urcl.impl.std.Vector3double> temp = getData2_vector3d_t(dpk, name);
        if (!temp.isEmpty()){
            List<Double> result = new ArrayList<>();
            Vector3double vec = temp.get();
            result.add(vec.get(0));
            result.add(vec.get(1));
            result.add(vec.get(2));
            return Optional.of(result);
        } else {
            return Optional.empty();
        }
    }
    @Override
    public Optional<List<Double>> getVector6d(String name) {
        java.util.Optional<de.dhbw.rahmlab.urcl.impl.std.Vector6double> temp = getData2_vector6d_t(dpk, name);
        if (!temp.isEmpty()){
            List<Double> result = new ArrayList<>();
            Vector6double vec = temp.get();
            result.add(vec.get(0));
            result.add(vec.get(1));
            result.add(vec.get(2));
            result.add(vec.get(3));
            result.add(vec.get(4));
            result.add(vec.get(5));
            return Optional.of(result);
        } else {
            return Optional.empty();
        }
    }
    @Override
    public Optional<List<Integer>> getVector6Int32(String name) {
        java.util.Optional<de.dhbw.rahmlab.urcl.impl.std.Vector6int32> temp = getData2_vector6int32_t(dpk, name);
        if (!temp.isEmpty()){
            List<Integer> result = new ArrayList<>();
            Vector6int32 vec = temp.get();
            result.add(vec.get(0));
            result.add(vec.get(1));
            result.add(vec.get(2));
            result.add(vec.get(3));
            result.add(vec.get(4));
            result.add(vec.get(5));
            return Optional.of(result);
        } else {
            return Optional.empty();
        }
    }
    @Override
    public Optional<List<Long>> getVector6UInt32(String name) {
       java.util.Optional<de.dhbw.rahmlab.urcl.impl.std.Vector6uint32> temp = getData2_vector6uint32_t(dpk, name);
       if (!temp.isEmpty()){
            List<Long> result = new ArrayList<>();
            Vector6uint32 vec = temp.get();
            result.add(vec.get(0));
            result.add(vec.get(1));
            result.add(vec.get(2));
            result.add(vec.get(3));
            result.add(vec.get(4));
            result.add(vec.get(5));
            return Optional.of(result);
        } else {
            return Optional.empty();
        }
    }
    
    
    @Override
    public java.util.Optional<String> getString(String name) {
        return getData2_string(dpk, name);
    }
}
