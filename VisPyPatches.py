from vispy.visuals import LineVisual
from vispy.visuals import axis as vispy_axis
from vispy.scene.widgets import Grid


_applied = False


def apply_patches():
    global _applied
    if _applied:
        return
    _applied = True

    # VisPy >= 0.7 already provides the crossed lines marker ('++') and
    # InfiniteLine with 1px default width, so no patches are needed for those.

    # Add clear_data method to LineVisual to have possibility of clearing data
    def clear_data(self):
        self._bounds = None
        self._pos = None
        self._changed['pos'] = True
        self.update()

    LineVisual.clear_data = clear_data

    # Patch VisPy Grid to prevent updating layout on PaintGL, which cause low fps
    def _prepare_draw(self, view):
        pass

    def _update_clipper(self):
        super(Grid, self)._update_clipper()
        try:
            self._update_child_widget_dim()
        except Exception as e:
            print(e)

    Grid._prepare_draw = _prepare_draw
    Grid._update_clipper = _update_clipper

    # Patch AxisVisual to have less axis labels (tick density 1 instead of 2)
    _get_ticks_talbot = vispy_axis._get_ticks_talbot

    def _get_ticks_talbot_sparse(dmin, dmax, n_inches, density=1.):
        return _get_ticks_talbot(dmin, dmax, n_inches, 1.)

    vispy_axis._get_ticks_talbot = _get_ticks_talbot_sparse
