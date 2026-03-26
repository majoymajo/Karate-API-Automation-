package automationexercise;

import com.intuit.karate.junit5.Karate;

class AutomationExerciseTest {

    @Karate.Test
    Karate testAll() {
        // Al usar Karate.run() sin argumentos, busca todos los archivos .feature
        // en el mismo paquete o subpaquetes.
        return Karate.run().relativeTo(getClass());
    }

}
