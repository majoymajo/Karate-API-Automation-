package automationexercise;

import com.intuit.karate.junit5.Karate;

class AutomationExerciseTest {

    @Karate.Test
    Karate testProducts() {
        return Karate.run("products").relativeTo(getClass());
    }

    @Karate.Test
    Karate testAccount() {
        return Karate.run("account").relativeTo(getClass());
    }

    @Karate.Test
    Karate testLogin() {
        return Karate.run("login").relativeTo(getClass());
    }

    @Karate.Test
    Karate testUserDetail() {
        return Karate.run("user_detail").relativeTo(getClass());
    }

}
