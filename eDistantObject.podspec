Pod::Spec.new do |s|

  s.name = "eDistantObject"
  s.version = "0.9.0"
  s.summary = "ObjC and Swift remote invocation framework"
  s.homepage = "https://github.com/brettfazio/eDistantObject"
  s.author = "Google Inc."
  s.summary = "eDistantObject provides users an easy way to make remote method invocations between processes in Objective-C and Swift without explicitly constructing RPC structures."
  s.license = { :type => "Apache 2.0", :file => "LICENSE" }
  s.source = { :git => "https://github.com/brettfazio/eDistantObject.git", :branch => "master" }

  # Subspec each folder so folders exist when pod is installed.

  # Can't have the public headers exist in the private headers as you won't be able to import them. Made these arrays because of this.
  service_public = %w[Service/Sources/EDOClientService.h
                     Service/Sources/EDOClientService+Device.h
                     Service/Sources/EDOClientServiceStatsCollector.h
                     Service/Sources/EDOHostNamingService.h
                     Service/Sources/EDOHostService.h
                     Service/Sources/EDOHostService+Device.h
                     Service/Sources/EDORemoteVariable.h
                     Service/Sources/EDOServiceError.h
                     Service/Sources/EDOServiceException.h
                     Service/Sources/EDOServicePort.h
                     Service/Sources/NSObject+EDOValueObject.h]

  service_private = (Dir.glob("Service/Sources/*.h")) - service_public
  
  s.pod_target_xcconfig = { 'USER_HEADER_SEARCH_PATHS' => '"${POD_ROOT}/**"', 'HEADER_SEARCH_PATHS' => '"${POD_ROOT}/**"' }

  
  s.subspec 'Service' do |service|
    service.source_files = "Service/Sources/*.{m,h}"
    service.public_header_files = service_public
    service.private_header_files = service_private
    #service.header_dir = "$(POD_ROOT)/eDistantObject/Service/Sources"
    service.header_mappings_dir = "Service/Sources"
  end

  s.subspec 'Channel' do |channel|
    channel.source_files = "Channel/Sources/*.{m,h}"
    channel.private_header_files = Dir.glob("Channel/Sources/*.h")
    #channel.header_dir = "$(POD_ROOT)/eDistantObject/Channel/Sources"
    channel.header_mappings_dir = "Channel/Sources"
  end

  s.subspec 'Measure' do |measure|
    measure.source_files = "Measure/Sources/*.{m,h}"
    measure.private_header_files = Dir.glob("Measure/Sources/*.h")
    #measure.header_dir = "$(POD_ROOT)/eDistantObject/eDistantObject/Measure/Sources"
    measure.header_mappings_dir = "Measure/Sources"
  end

  device_public = %w[Device/Sources/EDODeviceConnector.h
                     Device/Sources/EDODeviceDetector.h]
  device_private = (Dir.glob("Device/Sources/*.h")) - device_public

  s.subspec 'Device' do |device|
    device.source_files = "Device/Sources/*.{m,h}"
    device.public_header_files = device_public
    device.private_header_files = device_private
    #device.header_dir = "$(POD_ROOT)/eDistantObject/eDistantObject/Device/Sources"
    device.header_mappings_dir = "Device/Sources"
  end

  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.10"

end
