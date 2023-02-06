Compile with
```
./gradlew compileJava --console=verbose
```

Set up resources with
```
./gradlew processResources --console=verbose
```

or do both with
```
./gradlew classes --console=verbose
```

Package app into archive with:
```
./gradlew jar --console=verbose
```

Try out the app with:
```
./gradlew run --args="add 3 4"
```

Build an app distribution with:
```
./gradlew installDist --console=verbose
```

Create distributable app (in zip) with:
```
./gradlew distZip --console=verbose
```

for tar file use:
```
./gradlew distTar --console=verbose
```

Generate javadoc
```
./gradlew javadoc