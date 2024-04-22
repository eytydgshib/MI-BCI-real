using System;
using System.Windows.Forms;
using Tobii.Interaction;
using Gma.System.MouseKeyHook;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Threading.Tasks;
using WindowsInput;

namespace TobiiEyeTracking
{
    public partial class MainForm : Form
    {
        private Host _host;
        private GazePointDataStream _gazePointDataStream;

        
        private double alpha = 0.3;
        private PointD _smoothedPoint = new PointD(0, 0);

        public MainForm()
        {
            InitializeComponent();
            InitializeTobii();
        }

        private void InitializeComponent()
        {
            throw new NotImplementedException();
        }

        private void InitializeTobii()
        {
            _host = new Host();
            _gazePointDataStream = _host.Streams.CreateGazePointDataStream();
            _gazePointDataStream.GazePoint(OnGazePointReceived);
        }

        private void OnGazePointReceived(double x, double y, double timestamp)
        {
            
            _smoothedPoint.X = (_smoothedPoint.X * (1 - alpha)) + (x * alpha);
            _smoothedPoint.Y = (_smoothedPoint.Y * (1 - alpha)) + (y * alpha);

            // 转换平滑后的坐标到屏幕像素
            int screenX = (int)(_smoothedPoint.X * Screen.PrimaryScreen.Bounds.Width);
            int screenY = (int)(_smoothedPoint.Y * Screen.PrimaryScreen.Bounds.Height);

            this.Invoke((MethodInvoker)delegate
            {
                Cursor.Position = new System.Drawing.Point(screenX, screenY);
            });
        }

        protected override void OnFormClosed(FormClosedEventArgs e)
        {
            base.OnFormClosed(e);
            
            _host.Dispose();
        }
    }

    
    public class PointD
    {
        public double X { get; set; }
        public double Y { get; set; }

        public PointD(double x, double y)
        {
            X = x;
            Y = y;
        }
    }
}
