/*
===========================================================================
Loom SDK
Copyright 2011, 2012, 2013 
The Game Engine Company, LLC

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. 
===========================================================================
*/

package system {

/**
 *  The GC Class provides methods for invoking the LoomScript Garbage Collector.
 */
class GC {

    /** Stops the garbage collector. */
    public static const STOP = 0;
    /** Restarts the garbage collector. */
    public static const RESTART = 1;
    /** Performs a full garbage-collection cycle. */
    public static const COLLECT = 2;
    /** Returns the current amount of memory (in Kbytes) in use by the Lua VM. */
    public static const COUNT = 3;
    /** Returns the remainder of dividing the current amount of bytes of memory in use by Lua by 1024. */
    public static const COUNTB = 4;
    /**
     * Performs an incremental step of garbage collection. The step "size" is controlled by data (larger values mean more steps) 
     * in a non-specified way. If you want to control the step size you must experimentally tune the value of data. 
     * The function returns 1 if the step finished a garbage-collection cycle.
     */
    public static const STEP = 5;
    /** Sets data as the new value for the pause of the collector (see §2.10). The function returns the previous value of the pause. */
    public static const SETPAUSE = 6;
    /** Sets data as the new value for the step multiplier of the collector (see §2.10). The function returns the previous value of the step multiplier. */
    public static const SETSTEPMUL = 7;

    /**
     *  Forces the Garbage collection process. The default is to do a STEP (incremental) collection.
     */
    public static native function collect(cmd:Number = STEP, data:Number = 0);

    /**
     *  Gets the amount of RAM allocated by the VM in mebibytes (MiB)
     */
    public static native function getAllocatedMemory():Number;

    /**
     * Sets a warning level in megabytes for the VM
     * If the VM exceeds this level a warning will be displayed in 
     * the console.  Please note that this warning level is purely for the scripting
     * VM and not other assets that may be loaded.
     * @param   megabytes The memory threshold in megabytes that causes a warning when surpassed
     */
    public static native function setMemoryWarningLevel(megabytes:int);

    /**
     *  Runs a frame of GC collection (incremental), there is internal logic
     *  which will back off the GC if it is spiking. Note that the Loom Application class
     *  calls this internally. If you want to do a full collection, use GC.fullCollect();
     */
    public static native function update();


    /**
     * Does a full garbage collection cycle.
     */
    public static function fullCollect() {

        collect(COLLECT);

    }

}

}