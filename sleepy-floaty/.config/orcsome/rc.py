from orcsome import get_wm
import orcsome
import subprocess

wm = get_wm()

@wm.on_manage
def on_manage():
    @wm.on_property_change(wm.event_window, '_NET_WM_STATE')
    def property_was_set():
        w = wm.event_window
        if w.maximized_vert and w.maximized_horz:
            if w.decorated:
                wm.set_window_state(w, decorate=False)
        else:
            if not w.decorated:
                wm.set_window_state(w, decorate=True)
        #subprocess.call(['checkmax'])
