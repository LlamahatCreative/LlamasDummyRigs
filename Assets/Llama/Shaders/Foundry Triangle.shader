// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Llamahat/Foundry Triangle"
{
	Properties
	{
		_DMXChannel("DMX Channel", Float) = 0
		DMXGrid("DMX Grid", 2D) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 5.0
		#define ASE_VERSION 19801
		#pragma surface surf Unlit keepalpha noshadow novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		uniform sampler2D DMXGrid;
		uniform float _DMXChannel;
		float4 DMXGrid_TexelSize;


		float2 BaseRead( int DMXChannel )
		{
			uint ch = abs(DMXChannel);
			uint x = ch % 13;
			x = x == 0.0 ? 13.0 : x;
			float y = DMXChannel / 13.0;
			y = frac(y)== 0.00000 ? y - 1 : y;
			if(x == 13.0)
			{
			y = DMXChannel >= 90 && DMXChannel <= 101 ? y - 1 : y;
			        y = DMXChannel >= 160 && DMXChannel <= 205 ? y - 1 : y;
			        y = DMXChannel >= 326 && DMXChannel <= 404 ? y - 1 : y;
			        y = DMXChannel >= 676 && DMXChannel <= 819 ? y - 1 : y;
			        y = DMXChannel >= 1339 ? y - 1 : y;
			    }
			float2 xAndy = float2(x,y);
			return xAndy;
		}


		float2 LegacyRead( int channel, int sector )
		{
			channel = channel - 1;
			float x = 0.02000;
			float y = 0.02000;
			float ymod = floor(sector / 2.0); 
			float xmod = sector % 2.0;
			x+= (xmod * 0.50);
			y+= (ymod * 0.04);
			x+= (channel * 0.04);
			return float2(x,y);
		}


		float2 IndustryRead( float4 _OSCGridRenderTextureRAW_TexelSize, int x, int y )
		{
			y = y + 1;
			float resMultiplierX = (_OSCGridRenderTextureRAW_TexelSize.z / 13);
			float2 xyUV = float2(0.0,0.0);
			xyUV.x = ((x * resMultiplierX) * _OSCGridRenderTextureRAW_TexelSize.x);
			xyUV.y = (y * resMultiplierX) * _OSCGridRenderTextureRAW_TexelSize.y;
			xyUV.y -= 0.001915;
			 xyUV.x -= 0.015;
			return xyUV;
		}


		float SampleDMX88_g49( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g50( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g48( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g57( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g58( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g56( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g65( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g66( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		float SampleDMX88_g64( float4 c )
		{
			    float3 cRGB = float3(c.r, c.g, c.b);
			    float value = LinearRgbToLuminance(cRGB);
			    return value;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			int DMXChannel78_g67 = abs( (int)( _DMXChannel + 9.0 ) );
			float2 localBaseRead78_g67 = BaseRead( DMXChannel78_g67 );
			float2 break95_g67 = localBaseRead78_g67;
			int channel79_g67 = (int)break95_g67.x;
			int sector79_g67 = (int)break95_g67.y;
			float2 localLegacyRead79_g67 = LegacyRead( channel79_g67 , sector79_g67 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g67 = DMXGrid_TexelSize;
			int x84_g67 = (int)break95_g67.x;
			int y84_g67 = (int)break95_g67.y;
			float2 localIndustryRead84_g67 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g67 , x84_g67 , y84_g67 );
			v.vertex.xyz += ( tex2Dlod( DMXGrid, float4( ( 0 == 1 ? localLegacyRead79_g67 : localIndustryRead84_g67 ), 0, 0.0) ).r * float3(0,-2,0) );
			v.vertex.w = 1;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			int temp_output_6_0_g2 = 0;
			int temp_output_8_0_g2 = ( (int)_DMXChannel + 0 );
			int DMXChannel78_g49 = abs( temp_output_8_0_g2 );
			float2 localBaseRead78_g49 = BaseRead( DMXChannel78_g49 );
			float2 break95_g49 = localBaseRead78_g49;
			int channel79_g49 = (int)break95_g49.x;
			int sector79_g49 = (int)break95_g49.y;
			float2 localLegacyRead79_g49 = LegacyRead( channel79_g49 , sector79_g49 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g49 = DMXGrid_TexelSize;
			int x84_g49 = (int)break95_g49.x;
			int y84_g49 = (int)break95_g49.y;
			float2 localIndustryRead84_g49 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g49 , x84_g49 , y84_g49 );
			float4 c88_g49 = tex2D( DMXGrid, ( temp_output_6_0_g2 == 1 ? localLegacyRead79_g49 : localIndustryRead84_g49 ) );
			float localSampleDMX88_g49 = SampleDMX88_g49( c88_g49 );
			int temp_output_37_0_g2 = ( temp_output_8_0_g2 + 1 );
			int DMXChannel78_g50 = abs( temp_output_37_0_g2 );
			float2 localBaseRead78_g50 = BaseRead( DMXChannel78_g50 );
			float2 break95_g50 = localBaseRead78_g50;
			int channel79_g50 = (int)break95_g50.x;
			int sector79_g50 = (int)break95_g50.y;
			float2 localLegacyRead79_g50 = LegacyRead( channel79_g50 , sector79_g50 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g50 = DMXGrid_TexelSize;
			int x84_g50 = (int)break95_g50.x;
			int y84_g50 = (int)break95_g50.y;
			float2 localIndustryRead84_g50 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g50 , x84_g50 , y84_g50 );
			float4 c88_g50 = tex2D( DMXGrid, ( temp_output_6_0_g2 == 1 ? localLegacyRead79_g50 : localIndustryRead84_g50 ) );
			float localSampleDMX88_g50 = SampleDMX88_g50( c88_g50 );
			int DMXChannel78_g48 = abs( ( temp_output_37_0_g2 + 1 ) );
			float2 localBaseRead78_g48 = BaseRead( DMXChannel78_g48 );
			float2 break95_g48 = localBaseRead78_g48;
			int channel79_g48 = (int)break95_g48.x;
			int sector79_g48 = (int)break95_g48.y;
			float2 localLegacyRead79_g48 = LegacyRead( channel79_g48 , sector79_g48 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g48 = DMXGrid_TexelSize;
			int x84_g48 = (int)break95_g48.x;
			int y84_g48 = (int)break95_g48.y;
			float2 localIndustryRead84_g48 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g48 , x84_g48 , y84_g48 );
			float4 c88_g48 = tex2D( DMXGrid, ( temp_output_6_0_g2 == 1 ? localLegacyRead79_g48 : localIndustryRead84_g48 ) );
			float localSampleDMX88_g48 = SampleDMX88_g48( c88_g48 );
			float4 appendResult9_g2 = (float4(localSampleDMX88_g49 , localSampleDMX88_g50 , localSampleDMX88_g48 , 1.0));
			int temp_output_6_0_g55 = 0;
			int temp_output_8_0_g55 = ( (int)( _DMXChannel + 3.0 ) + 0 );
			int DMXChannel78_g57 = abs( temp_output_8_0_g55 );
			float2 localBaseRead78_g57 = BaseRead( DMXChannel78_g57 );
			float2 break95_g57 = localBaseRead78_g57;
			int channel79_g57 = (int)break95_g57.x;
			int sector79_g57 = (int)break95_g57.y;
			float2 localLegacyRead79_g57 = LegacyRead( channel79_g57 , sector79_g57 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g57 = DMXGrid_TexelSize;
			int x84_g57 = (int)break95_g57.x;
			int y84_g57 = (int)break95_g57.y;
			float2 localIndustryRead84_g57 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g57 , x84_g57 , y84_g57 );
			float4 c88_g57 = tex2D( DMXGrid, ( temp_output_6_0_g55 == 1 ? localLegacyRead79_g57 : localIndustryRead84_g57 ) );
			float localSampleDMX88_g57 = SampleDMX88_g57( c88_g57 );
			int temp_output_37_0_g55 = ( temp_output_8_0_g55 + 1 );
			int DMXChannel78_g58 = abs( temp_output_37_0_g55 );
			float2 localBaseRead78_g58 = BaseRead( DMXChannel78_g58 );
			float2 break95_g58 = localBaseRead78_g58;
			int channel79_g58 = (int)break95_g58.x;
			int sector79_g58 = (int)break95_g58.y;
			float2 localLegacyRead79_g58 = LegacyRead( channel79_g58 , sector79_g58 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g58 = DMXGrid_TexelSize;
			int x84_g58 = (int)break95_g58.x;
			int y84_g58 = (int)break95_g58.y;
			float2 localIndustryRead84_g58 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g58 , x84_g58 , y84_g58 );
			float4 c88_g58 = tex2D( DMXGrid, ( temp_output_6_0_g55 == 1 ? localLegacyRead79_g58 : localIndustryRead84_g58 ) );
			float localSampleDMX88_g58 = SampleDMX88_g58( c88_g58 );
			int DMXChannel78_g56 = abs( ( temp_output_37_0_g55 + 1 ) );
			float2 localBaseRead78_g56 = BaseRead( DMXChannel78_g56 );
			float2 break95_g56 = localBaseRead78_g56;
			int channel79_g56 = (int)break95_g56.x;
			int sector79_g56 = (int)break95_g56.y;
			float2 localLegacyRead79_g56 = LegacyRead( channel79_g56 , sector79_g56 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g56 = DMXGrid_TexelSize;
			int x84_g56 = (int)break95_g56.x;
			int y84_g56 = (int)break95_g56.y;
			float2 localIndustryRead84_g56 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g56 , x84_g56 , y84_g56 );
			float4 c88_g56 = tex2D( DMXGrid, ( temp_output_6_0_g55 == 1 ? localLegacyRead79_g56 : localIndustryRead84_g56 ) );
			float localSampleDMX88_g56 = SampleDMX88_g56( c88_g56 );
			float4 appendResult9_g55 = (float4(localSampleDMX88_g57 , localSampleDMX88_g58 , localSampleDMX88_g56 , 1.0));
			int temp_output_6_0_g63 = 0;
			int temp_output_8_0_g63 = ( (int)( _DMXChannel + 6.0 ) + 0 );
			int DMXChannel78_g65 = abs( temp_output_8_0_g63 );
			float2 localBaseRead78_g65 = BaseRead( DMXChannel78_g65 );
			float2 break95_g65 = localBaseRead78_g65;
			int channel79_g65 = (int)break95_g65.x;
			int sector79_g65 = (int)break95_g65.y;
			float2 localLegacyRead79_g65 = LegacyRead( channel79_g65 , sector79_g65 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g65 = DMXGrid_TexelSize;
			int x84_g65 = (int)break95_g65.x;
			int y84_g65 = (int)break95_g65.y;
			float2 localIndustryRead84_g65 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g65 , x84_g65 , y84_g65 );
			float4 c88_g65 = tex2D( DMXGrid, ( temp_output_6_0_g63 == 1 ? localLegacyRead79_g65 : localIndustryRead84_g65 ) );
			float localSampleDMX88_g65 = SampleDMX88_g65( c88_g65 );
			int temp_output_37_0_g63 = ( temp_output_8_0_g63 + 1 );
			int DMXChannel78_g66 = abs( temp_output_37_0_g63 );
			float2 localBaseRead78_g66 = BaseRead( DMXChannel78_g66 );
			float2 break95_g66 = localBaseRead78_g66;
			int channel79_g66 = (int)break95_g66.x;
			int sector79_g66 = (int)break95_g66.y;
			float2 localLegacyRead79_g66 = LegacyRead( channel79_g66 , sector79_g66 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g66 = DMXGrid_TexelSize;
			int x84_g66 = (int)break95_g66.x;
			int y84_g66 = (int)break95_g66.y;
			float2 localIndustryRead84_g66 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g66 , x84_g66 , y84_g66 );
			float4 c88_g66 = tex2D( DMXGrid, ( temp_output_6_0_g63 == 1 ? localLegacyRead79_g66 : localIndustryRead84_g66 ) );
			float localSampleDMX88_g66 = SampleDMX88_g66( c88_g66 );
			int DMXChannel78_g64 = abs( ( temp_output_37_0_g63 + 1 ) );
			float2 localBaseRead78_g64 = BaseRead( DMXChannel78_g64 );
			float2 break95_g64 = localBaseRead78_g64;
			int channel79_g64 = (int)break95_g64.x;
			int sector79_g64 = (int)break95_g64.y;
			float2 localLegacyRead79_g64 = LegacyRead( channel79_g64 , sector79_g64 );
			float4 _OSCGridRenderTextureRAW_TexelSize84_g64 = DMXGrid_TexelSize;
			int x84_g64 = (int)break95_g64.x;
			int y84_g64 = (int)break95_g64.y;
			float2 localIndustryRead84_g64 = IndustryRead( _OSCGridRenderTextureRAW_TexelSize84_g64 , x84_g64 , y84_g64 );
			float4 c88_g64 = tex2D( DMXGrid, ( temp_output_6_0_g63 == 1 ? localLegacyRead79_g64 : localIndustryRead84_g64 ) );
			float localSampleDMX88_g64 = SampleDMX88_g64( c88_g64 );
			float4 appendResult9_g63 = (float4(localSampleDMX88_g65 , localSampleDMX88_g66 , localSampleDMX88_g64 , 1.0));
			o.Emission = ( ( appendResult9_g2 * i.vertexColor.r ) + ( appendResult9_g55 * i.vertexColor.g ) + ( appendResult9_g63 * i.vertexColor.b ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "AmplifyShaderEditor.MaterialInspector"
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.RangedFloatNode;2;-2048,256;Inherit;False;Property;_DMXChannel;DMX Channel;0;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;3;-2176,0;Inherit;True;Property;DMXGrid;DMX Grid;1;0;Create;True;0;0;0;False;0;False;87c3021d20ea2004cad2ca0d2dd14d07;87c3021d20ea2004cad2ca0d2dd14d07;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.SimpleAddOpNode;32;-1568,192;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-1568,352;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;13;-1280,-192;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;4;-1408,0;Inherit;False;VRSL-GetRGBValues;-1;;2;6ff3fb2f25dfde442a3d454ce5bfa464;0;4;53;SAMPLER2D;0;False;4;INT;0;False;6;INT;0;False;7;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;7;-1408,160;Inherit;False;VRSL-GetRGBValues;-1;;55;6ff3fb2f25dfde442a3d454ce5bfa464;0;4;53;SAMPLER2D;0;False;4;INT;0;False;6;INT;0;False;7;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;10;-1408,320;Inherit;False;VRSL-GetRGBValues;-1;;63;6ff3fb2f25dfde442a3d454ce5bfa464;0;4;53;SAMPLER2D;0;False;4;INT;0;False;6;INT;0;False;7;INT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-1568,512;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;9;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1;-1408,480;Inherit;False;VRSL-ReadDMXRaw;-1;;67;257ccf99ab7848440b204b69d9f82d8e;0;3;96;SAMPLER2D;0;False;80;INT;0;False;77;INT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-896,0;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-896,160;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-896,320;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;18;-1088,608;Inherit;False;Constant;_DisplacementAmount;Displacement Amount;2;0;Create;True;0;0;0;False;0;False;0,-2,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-768,480;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;31;-528,0;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-352,0;Float;False;True;-1;7;AmplifyShaderEditor.MaterialInspector;0;0;Unlit;Foundry Triangle;False;False;False;False;False;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;16;FLOAT4;0,0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;2;0
WireConnection;33;0;2;0
WireConnection;4;53;3;0
WireConnection;4;4;2;0
WireConnection;7;53;3;0
WireConnection;7;4;32;0
WireConnection;10;53;3;0
WireConnection;10;4;33;0
WireConnection;34;0;2;0
WireConnection;1;96;3;0
WireConnection;1;77;34;0
WireConnection;28;0;4;0
WireConnection;28;1;13;1
WireConnection;29;0;7;0
WireConnection;29;1;13;2
WireConnection;30;0;10;0
WireConnection;30;1;13;3
WireConnection;19;0;1;0
WireConnection;19;1;18;0
WireConnection;31;0;28;0
WireConnection;31;1;29;0
WireConnection;31;2;30;0
WireConnection;0;2;31;0
WireConnection;0;11;19;0
ASEEND*/
//CHKSM=5275FDA377E23919330C9E0091D92EFCCBED3ECA