from django.db import models

class pythondemo(models.Model):
    title = models.CharField(max_length = 200)
    desc = models.TextField()
def __str__(self):
    return self.title
