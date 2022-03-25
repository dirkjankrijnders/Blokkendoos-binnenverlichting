$fn=144;

square_guide = [3.56, 0, 2.7];
d_guide = 1 + 0.2;

sep_round_guide = 9.5;//8.53; // 15.8;

d_calipers = 16;
h_roof = 1;

r_roof = d_calipers^2 / (8*h_roof) + (h_roof / 2);
echo("r_roof=", r_roof);
base = [20, 4, 30] + [1, 0, 0];
h_guides = r_roof - 4.65 + 0.55; //29;
led = [4, 3.7, 4.05];

sep_roof_align = (19.59 + 14.27) / 2;
d_roof_align = (19.59 - 14.27) / 2 + 0.2;


module roof_align(sep, d) {
    for (x = [-sep/2, sep/2]) {
        translate([x, 0, 0])
            cylinder(d=d, h=100);
    };
}

module base_block(size, extra_y) {
    intersection(){
        union() {
            translate([-size[0]/2, 0, h_guides])
                cube(size);
            translate([-size[0]/2, -extra_y, h_guides - 1.5])
                cube([size[0], extra_y, size[2]+1.5]);
        };
        translate([0, -2, 0])
            rotate([-90, 0, 0])
                cylinder(h=size[1] + extra_y + 0.2, r = r_roof);
    }
};

module led_block(size) {
    translate([-size[0]/2, -size[1], 0])
        cube(size);
}


difference() {
    // #translate([0, 0, 0])
    base_block(base, 2);
    translate([0, d_roof_align / 2, 0])
        #roof_align(sep_roof_align, d_roof_align);
    for (x = [-1, 1]) {
        translate([x * sep_round_guide/2, -0.1, h_guides+0.2+ d_guide/2])
            rotate([-90, 0, 0])
                cylinder(d=d_guide, h =10);
    };
    translate([-square_guide[0]/2, -0.1, h_guides])
        cube(square_guide + [0, base[2] + 0.2, 0]);
    translate([0, 0, h_guides - 1.5 ])
        led_block(led);
    for (x = [-1, 1]) {
        translate([x * sep_round_guide/2, 0, h_guides - 1.5])
            led_block(led);
    }
};


