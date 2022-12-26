wire OUT, IN1, IN2;

// basic gate instantiations\

and a1(OUT, IN1, IN2);
nand na1(OUT, IN1, IN2);
or o1(OUT, IN1, IN2);
nor no1(OUT, IN1, IN2);
not n1(OUT, IN1);
buf b1(OUT, IN1);
xor x1(OUT, IN1, IN2);
xnor xn1(OUT, IN1, IN2);

// gates with more than two inputs are instantiated by simply adding more input ports in the gate instantiation
// gates can also be instantiated without using instance name

// Buffif and Notif
/*
Buffif1: in = out if ctrl = 1;
Buffif0: in = out if ctrl = 0;

Notif1: in = ~out if ctrl = 1;
Notif0: in = ~out if ctrl = 0;
*/
wire out, in, ctrl;
bufif1 b1(out, in, ctrl);
bufif0 b0(out, in, ctrl);

notif1 n1(out, in, ctrl);
notif0 n0(out, in, ctrl);
