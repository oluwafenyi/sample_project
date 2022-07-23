import random

from django.views.generic import TemplateView
from django.templatetags.static import static


class IndexView(TemplateView):
    template_name = "pages/home.html"

    photos = [
        "images/photos/wallhaven-0joedm.jpg",
        "images/photos/wallhaven-4xj6eo.png",
        "images/photos/wallhaven-6kq27w.jpg",
    ]

    photos = [static(link) for link in photos]

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["background_photo"] = random.choice(self.photos)
        return context
