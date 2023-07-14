from unittest import TestCase
from unittest.mock import patch

from PIL import Image

from staticmap import Line, StaticMap
from staticmap.staticmap import _lat_to_y, _lon_to_x, _y_to_lat, _x_to_lon


class LonLatConversionTest(TestCase):
    def testLon(self):
        for lon in range(-180, 180, 20):
            for zoom in range(0, 10):
                x = _lon_to_x(lon, zoom)
                l = _x_to_lon(x, zoom)
                self.assertAlmostEqual(lon, l, places=5)

    def testLat(self):
        for lat in range(-89, 89, 2):
            for zoom in range(0, 10):
                y = _lat_to_y(lat, zoom)
                l = _y_to_lat(y, zoom)
                self.assertAlmostEqual(lat, l, places=5)


class RenderTest(TestCase):
    @staticmethod
    def test_renders_calls_resize_with_LANCZOS():
        # Image.ANTIALIAS have been removed in Pillow 10+
        # https://pillow.readthedocs.io/en/stable/releasenotes/10.0.0.html#constants
        width = 400
        height = 25
        m = StaticMap(width, height)
        m.headers = {"User-Agent": "Mozilla 5.0"}
        m.add_line(Line([(13.4, 52.5), (2.3, 48.9)], "blue", 3))
        with patch.object(
            Image.Image,
            "resize",
            side_effect=[Image.new('RGBA', (width, height), (255, 0, 0, 0))]
        ) as resize_mock:
            m.render()

        resize_mock.assert_called_with((width, height), Image.LANCZOS)
