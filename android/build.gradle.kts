import org.gradle.api.tasks.compile.JavaCompile
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory =
        newBuildDir.dir(project.name)

    project.layout.buildDirectory.value(newSubprojectBuildDir)

    project.evaluationDependsOn(":app")
}

/*
 * Keep Java and Kotlin JVM targets consistent for all Android/Kotlin plugins.
 * This is especially important for camera_android_camerax, flutter_tts,
 * and speech_to_text.
 */
gradle.projectsEvaluated {
    allprojects {
        tasks.withType<JavaCompile>().configureEach {
            sourceCompatibility = "17"
            targetCompatibility = "17"
            options.release.set(17)
        }

        tasks.withType<KotlinCompile>().configureEach {
            compilerOptions {
                jvmTarget.set(JvmTarget.JVM_17)
            }
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}