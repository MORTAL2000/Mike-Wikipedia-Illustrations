// Title: CIE LCHab Color Solid Cylinder Mesh
// Authors: Michael Horvath, with formulas by Christoph Lipka
// Website: http://isometricland.net
// Created: 2017-03-22
// Updated: 2017-03-27
// This file is licensed under the terms of the CC-GNU LGPL.
// http://www.gnu.org/licenses/lgpl-2.1.html
// Illuminant =  D65
// Observer   =  2� (1931)
// +kfi0 +kff191 +kc

#version 3.7;
#declare cie_ScaleAmount	= 200;
#declare cie_RotateAmount	= 30;
#declare cie_TransAmount	= <0,-1/2,0>;
#declare cie_AxesScale		= 8/8;
#declare cie_cam_distance	= 17;
#declare cie_cam_planesize	= cie_cam_distance/10;
#declare cie_cam_aspectratio	= image_width/image_height;
#declare cie_paint_triangles	= true;
#declare cie_pre_xyz_visible	= false;	// pre-populate XYZ tables on disk
#declare cie_pre_mesh_visible	= false;	// pre-populate mesh geometry on disk
#declare cie_cspace0_visible	= 3;
#declare cie_mesh_file_visible	= "cie_visible_lchab_cyl_d65_mesh.inc";

#include "cie_color_conversion_formulas.inc"
#include "cie_mesh_generation.inc"
#include "cie_basic_scene_settings.inc"

union
{
	polygon
	{
		4, <0, 0,>, <1, 0,>, <1, 1,>, <0, 1,>
		pigment {image_map {png "cie_axis_H360_cyl_sans_360_ccw.png"}}
		translate	<-0.5, -0.5>
		scale		2*440/320
		rotate		+x * 90
		rotate		+y * 270
		scale		cie_AxesScale
		translate	-y * 0.00001
	}
	polygon
	{
		4, <0, 0,>, <1, 0,>, <1, 1,>, <0, 1,>
		pigment {image_map {png "cie_axis_L100_C200_cyl_sans_360.png"}}
		scale		440/320
		translate	-y * ((440-320)/2 * 440/320)/440
		translate	-x * ((440-320)/2 * 440/320)/440
		scale		cie_AxesScale
		translate	0
	}
	union
	{
//		cie_plot_gridlines_visible(3)
//		cie_plot_polkadots_visible(3)
		#include cie_mesh_file_visible
		#if (cie_paint_triangles = false)
			pigment {cie_pigmentRGB}
			finish {cie_isoFinish}
		#end
	}
	object
	{
		cie_cylShape
	//	pigment {cie_pigmentGradY}
	//	pigment {cie_pigmentRGB}
		pigment {color rgbt  7/8}
		finish {cie_boxFinish}
	}

//	object {cie_axesShape finish {cie_boxFinish}}

	translate	cie_TransAmount
	scale		cie_ScaleAmount
	rotate		+y * cie_RotateAmount
	rotate		+y * clock * 360
}
