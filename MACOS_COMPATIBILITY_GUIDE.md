# macOS Compatibility Guide

## Overview
Comprehensive guide for fixing macOS compatibility issues in the cagent project. This document addresses platform-specific challenges and provides solutions for cross-platform functionality.

## Common macOS Issues & Solutions

### 1. Path Handling

**Issue:** File paths differ between macOS and Linux
```swift
// ❌ Wrong
let path = "/home/user/file.txt"

// ✅ Correct
let path = FileManager.default.homeDirectoryForCurrentUser
    .appendingPathComponent("file.txt").path
```

### 2. Process Management

**Issue:** Process spawning differs on macOS
```swift
// ✅ macOS-compatible process spawning
import Foundation

let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
process.arguments = ["python3", "script.py"]

let pipe = Pipe()
process.standardOutput = pipe

try process.run()
process.waitUntilExit()

let data = pipe.fileHandleForReading.readDataToEndOfFile()
let output = String(data: data, encoding: .utf8)
```

### 3. Framework Availability

**Issue:** Some frameworks unavailable on macOS
```swift
#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
class PlatformController: NSViewController {
    // macOS implementation
}
#else
class PlatformController: UIViewController {
    // iOS implementation
}
#endif
```

### 4. Temporary Directory Access

**Issue:** Temp directory paths vary by platform
```swift
// ✅ Cross-platform temp directory
let tempDir = FileManager.default.temporaryDirectory
let tempFile = tempDir.appendingPathComponent("cagent_temp.txt")
```

### 5. Environment Variables

**Issue:** Shell environments differ on macOS
```swift
// ✅ Safe environment variable access
let env = ProcessInfo.processInfo.environment
let pythonPath = env["PYTHON_PATH"] ?? "/usr/bin/python3"
```

## Build Configuration

### Xcode Settings for macOS

```swift
// Package.swift
import PackageDescription

let package = Package(
    name: "cagent",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // macOS-compatible dependencies only
    ],
    targets: [
        .target(
            name: "cagent",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .debug))
            ]
        )
    ]
)
```

## Testing on macOS

### Test Script
```bash
#!/bin/bash
set -e

echo "Testing macOS compatibility..."

# Check Swift version
swift --version

# Run unit tests
swift test -c debug

# Run integration tests
swift test -c release

# Verify code formatting
swift format --verify .

echo "✅ All tests passed"
```

## CI/CD Configuration

### GitHub Actions for macOS
```yaml
name: macOS Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    strategy:
      matrix:
        swift-version: ["5.8", "5.9"]
    steps:
      - uses: actions/checkout@v3
      - uses: swift-actions/setup-swift@v1
        with:
          swift-version: ${{ matrix.swift-version }}
      - run: swift test -c debug
      - run: swift build -c release
```

## Common Gotchas

| Issue | Cause | Solution |
|-------|-------|----------|
| Code signing errors | Security policies | Disable signing in Xcode build settings |
| Linker errors | Missing frameworks | Add frameworks to `link` in Package.swift |
| Runtime crashes | Memory layout differences | Use platform-specific struct sizes |
| File permission errors | POSIX differences | Use FileManager API instead of shell |
| Executable not found | $PATH issues | Use full paths or Bundle resources |

## Code Examples

### Safe Shell Command Execution
```swift
func runCommand(_ command: String, args: [String]) throws -> String {
    let task = Process()
    
    // Use which to find command
    let whichTask = Process()
    whichTask.executableURL = URL(fileURLWithPath: "/usr/bin/which")
    whichTask.arguments = [command]
    
    let pipe = Pipe()
    whichTask.standardOutput = pipe
    try whichTask.run()
    whichTask.waitUntilExit()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    guard let execPath = String(data: data, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines) else {
        throw NSError(domain: "Command not found", code: -1)
    }
    
    task.executableURL = URL(fileURLWithPath: execPath)
    task.arguments = args
    
    let outputPipe = Pipe()
    task.standardOutput = outputPipe
    
    try task.run()
    task.waitUntilExit()
    
    let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: outputData, encoding: .utf8) ?? ""
}
```

### Platform Detection Utility
```swift
enum Platform {
    case macos
    case linux
    case other
    
    static var current: Platform {
        #if os(macOS)
        return .macos
        #elseif os(Linux)
        return .linux
        #else
        return .other
        #endif
    }
    
    var supportsNativeUI: Bool {
        switch self {
        case .macos:
            return true
        case .linux, .other:
            return false
        }
    }
}
```

## Performance Optimization

### macOS-Specific Optimizations
```swift
// Use DispatchQueue for better performance on macOS
let queue = DispatchQueue(label: "com.cagent.processing", 
                         attributes: .concurrent)

// Batch file operations
let fileManager = FileManager.default
try fileManager.createDirectory(atPath: dirPath, 
                               withIntermediateDirectories: true)

// Use NSCache for memory-efficient caching
let cache = NSCache<NSString, NSData>()
```

## Debugging Tools

### Useful macOS Development Tools
- **lldb**: Interactive debugger
- **Instruments**: Performance profiling
- **Activity Monitor**: Process monitoring
- **Console.app**: System logs
- **Xcode Organizer**: Device/simulator management

### Debug Logging
```swift
import os

let log = OSLog(subsystem: "com.cagent", category: "debug")

os_log("macOS debug: %@", log: log, type: .debug, message)
```

## Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [Swift.org](https://swift.org/)
- [macOS Release Notes](https://developer.apple.com/macos/)
- [GitHub Actions on macOS](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners#supported-runners-and-hardware-resources)
