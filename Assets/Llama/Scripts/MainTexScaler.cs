
using UdonSharp;
using UnityEngine;
using VRC.SDKBase;
using VRC.Udon;

namespace Llamahat
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class MainTexScaler : UdonSharpBehaviour
    {
        public MeshRenderer[] meshRenderers;

        public Vector2 SceneResolution;
        public Vector2[] SliceResolution;
        public Vector2[] SlicePosition;
        private Vector2[] ProcessedSlicePosition;
        private Vector2[] LaserScaling;
        private Vector2[] LaserOffsets;
        public void Start()
        {
            InitializeArrays();
            CalculateScalingAndOffset();
            SetRendererScalingAndOffset();
        }

        public void InitializeArrays(){
            int arrayLength = meshRenderers.Length;
            LaserScaling = new Vector2[arrayLength];
            LaserOffsets = new Vector2[arrayLength];
            ProcessedSlicePosition = new Vector2[arrayLength];
        }

        public void CalculateScalingAndOffset(){
            for (int i = 0; i < meshRenderers.Length; i++)
            {
                ProcessedSlicePosition[i].y = SceneResolution.y - (SlicePosition[i].y + SliceResolution[i].y);
                ProcessedSlicePosition[i].x = SlicePosition[i].x;
                 
                LaserScaling[i] = SliceResolution[i]/SceneResolution;
                LaserOffsets[i] = ProcessedSlicePosition[i]/SceneResolution;
            }
        }

        public void SetRendererScalingAndOffset()
        {
            for (int i = 0; i < meshRenderers.Length; i++)
            {
                meshRenderers[i].material.SetTextureScale("_MainTex", LaserScaling[i]);
                meshRenderers[i].material.SetTextureOffset("_MainTex", LaserOffsets[i]);
            }
        }
    }
}

