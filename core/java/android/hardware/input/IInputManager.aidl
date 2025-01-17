/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.hardware.input;

import android.app.IInputForwarder;
import android.hardware.input.InputDeviceIdentifier;
import android.hardware.input.KeyboardLayout;
import android.hardware.input.IInputDevicesChangedListener;
import android.hardware.input.ITabletModeChangedListener;
import android.hardware.input.TouchCalibration;
import android.os.IBinder;
import android.view.InputDevice;
import android.view.InputEvent;
import android.view.PointerIcon;

/** @hide */
interface IInputManager {
    // Gets input device information.
    InputDevice getInputDevice(int deviceId);
    int[] getInputDeviceIds();

    // Enable/disable input device.
    boolean isInputDeviceEnabled(int deviceId);
    void enableInputDevice(int deviceId);
    void disableInputDevice(int deviceId);

    // Reports whether the hardware supports the given keys; returns true if successful
    boolean hasKeys(int deviceId, int sourceMask, in int[] keyCodes, out boolean[] keyExists);

    // Temporarily changes the pointer speed.
    void tryPointerSpeed(int speed);

    // Injects an input event into the system.  To inject into windows owned by other
    // applications, the caller must have the INJECT_EVENTS permission.
    boolean injectInputEvent(in InputEvent ev, int mode);

    boolean injectInputEventInternal(in InputEvent ev, int displayId, int mode);

    // Calibrate input device position
    TouchCalibration getTouchCalibrationForInputDevice(String inputDeviceDescriptor, int rotation);
    void setTouchCalibrationForInputDevice(String inputDeviceDescriptor, int rotation,
            in TouchCalibration calibration);

    // Keyboard layouts configuration.
    KeyboardLayout[] getKeyboardLayouts();
    KeyboardLayout[] getKeyboardLayoutsForInputDevice(in InputDeviceIdentifier identifier);
    KeyboardLayout getKeyboardLayout(String keyboardLayoutDescriptor);
    String getCurrentKeyboardLayoutForInputDevice(in InputDeviceIdentifier identifier);
    void setCurrentKeyboardLayoutForInputDevice(in InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor);
    String[] getEnabledKeyboardLayoutsForInputDevice(in InputDeviceIdentifier identifier);
    void addKeyboardLayoutForInputDevice(in InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor);
    void removeKeyboardLayoutForInputDevice(in InputDeviceIdentifier identifier,
            String keyboardLayoutDescriptor);

    // Registers an input devices changed listener.
    void registerInputDevicesChangedListener(IInputDevicesChangedListener listener);

    // Queries whether the device is currently in tablet mode
    int isInTabletMode();
    // Registers a tablet mode change listener
    void registerTabletModeChangedListener(ITabletModeChangedListener listener);

    // Input device vibrator control.
    void vibrate(int deviceId, in long[] pattern, int repeat, IBinder token);
    void cancelVibrate(int deviceId, IBinder token);

    void setPointerIconType(int typeId);
    void setCustomPointerIcon(in PointerIcon icon);

    void requestPointerCapture(IBinder windowToken, boolean enabled);

    /** Create input forwarder to deliver touch events to owned display. */
    IInputForwarder createInputForwarder(int displayId);
}
