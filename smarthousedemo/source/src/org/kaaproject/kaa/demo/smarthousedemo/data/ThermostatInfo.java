/**
 *  Copyright 2014-2016 CyberVision, Inc.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

package org.kaaproject.kaa.demo.smarthousedemo.data;

public class ThermostatInfo extends SmartDeviceInfo {
    
    public ThermostatInfo(String endpointKey) {
        super(endpointKey);
    }

    @Override
    public DeviceType getDeviceType() {
        return DeviceType.THERMOSTAT;
    }
    
    public org.kaaproject.kaa.demo.smarthouse.thermo.ThermostatInfo getThermostatInfo() {
        return (org.kaaproject.kaa.demo.smarthouse.thermo.ThermostatInfo)deviceInfo;
    }
}
