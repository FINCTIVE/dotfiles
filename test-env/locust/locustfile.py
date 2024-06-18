from locust import HttpUser, task, between

class QuickstartUser(HttpUser):
    #wait_time = between(1, 2.5)
    wait_time = lambda x: 0

    @task
    def test_path(self):
        self.client.get("/test-path")
