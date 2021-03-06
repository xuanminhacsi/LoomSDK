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

package loom.graphics
{
    import loom2d.display.DisplayObject;
    import loom2d.math.Matrix;
    
    /**
     * Delegate that is called when screenshot data is ready to be delivered after calling `Graphics.screenshotData()`
     * 
     * @param pngData The raw PNG data (as a ByteArray)
     */
    delegate ScreenshotDataDelegate(pngData:ByteArray);
    
    /**
     * Control global graphics subsystem behavior.
     */
    public native class Graphics
    {
        /**
         * Delegate that will be fired when screenshot data is gathered and ready to be consumed.
         * The expected delegate signature is `function(byteArray):void`
         * 
         * See the screenshotData function for more information
         * @see screenshotData
         */
        public static native var onScreenshotData:ScreenshotDataDelegate;
        
        /**
         * Private API; simulates graphics context loss.
         */
        public static native function handleContextLoss():void;

        /**
         * Take a screenshot and save it to the specified path (in PNG format).
         */
        public static native function screenshot(path:String):void;
        
        /**
         * Take a screenshot and return the raw data in the onScreenshotData delegate
         * 
         * This function will not return anything, instead it will trigger the graphics system to take
         * a screenshot at the end of the current frame. Therefore, in order to get the screenshot data the
         * onScreenshotData delegate must be used
         */
        public static native function screenshotData():void;

        /// No debug features enabled.
        public static var DEBUG_NONE 		= 0;

        /// Draw everything in wireframe.
        public static var DEBUG_WIREFRAME 	= 1;

        /// Simulate infinitely fast hardware - all draws do nothing. Useful
        /// for determining CPU/GPU bottleneck.
        public static var DEBUG_IFH 		= 2;

        /// Show internal statistics.
        public static var DEBUG_STATS 		= 4;

        /// Show debug text.
        public static var DEBUG_TEXT 		= 8;
        
        /**
         * Control debug mode behavior; see the DEBUG_* flags for details.
         */
        public static native function setDebug(flags:int):void;

        /** Render the object immediately with transform and alpha parameters.
         *  Used internally for rendering to a texture.
         * 
         *  @param object       The object to draw.
         *  @param matrix       If 'matrix' is null, the object will be drawn adhering its 
         *                      properties for position, scale, and rotation. If it is not null,
         *                      the object will be drawn in the orientation depicted by the matrix.
         *  @param alpha        The object's alpha value will be multiplied with this value.
         */
        public static native function render(object:DisplayObject, matrix:Matrix = null, alpha:Number = 1);
        
        /** 
         * Set the background color for the graphics viewport, in RGBA.
         */ 
        public static native function setFillColor(color:int):void;

    }

}