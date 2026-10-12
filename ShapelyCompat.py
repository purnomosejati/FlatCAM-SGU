"""
Shapely 1.x compatibility for Shapely 2.x.

FlatCAM was written for Shapely 1.x, where multi-part geometries
(MultiPolygon, MultiLineString, GeometryCollection, ...) could be
iterated directly. Shapely 2 requires going through ``.geoms``.
Restore iteration so the legacy ``for part in geometry`` loops keep working.

Only ``__iter__`` is restored on purpose: adding ``__len__``/``__getitem__``
would make NumPy treat geometries as sequences and break Shapely 2's
vectorized operations (e.g. ``MultiPolygon.buffer()`` returning an array).
Code needing length or indexing must use ``.geoms`` explicitly.

Import this module before any geometry is created.
"""

from shapely.geometry.base import BaseMultipartGeometry


def _iter(self):
    return iter(self.geoms)


if not hasattr(BaseMultipartGeometry, '__iter__'):
    BaseMultipartGeometry.__iter__ = _iter
