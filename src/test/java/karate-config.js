function configureKarate() {
    const config = {
        baseUrl: 'https://automationexercise.com'
    };
    karate.configure('ssl', true);
    karate.configure('connectTimeout', 10000);
    karate.configure('readTimeout', 10000);
    karate.configure('retry', { count: 3, interval: 3000 });
    return config;
}
