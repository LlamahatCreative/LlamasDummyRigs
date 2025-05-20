
using UdonSharp;
using UnityEngine;
using UnityEngine.UIElements;
using VRC.SDKBase;
using VRC.Udon;
using VRSL;

namespace Llamahat
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.None)]
    public class VRSL_GPUReadback_TriangleTransform : UdonSharpBehaviour
    {
        public GameObject targetObject;

        public VRSL_ReadBackFunction VRSL_RB;
        public int[] ReadbackIndices = new int[3] { 0, 1, 2 };
        private Vector3 a = new Vector3(0, 0, 0);
        private Vector3 b = new Vector3(0, 0, 0);
        private Vector3 c = new Vector3(0, 0, 0);        
        public float triangleRadius = 1f;
        private Vector3 normalDirection = new Vector3(0, 0, 0);
        private Quaternion initialRotation = new Quaternion(0, 0, 0, 1);
        private Vector3 initialPosition = new Vector3(0, 0, 0);
        public float HeightMultiplier = 1f;
        void Start()
        {
            if (targetObject == null)
            {
                Debug.LogError("Target object is not assigned.");
                targetObject = gameObject;
                Debug.LogWarning("Target object set to self.");
            }
            initialRotation = targetObject.transform.rotation;
            initialPosition = targetObject.transform.position;

            a = new Vector3(triangleRadius, 0, 0);
            b = new Vector3(-triangleRadius / 2, 0, -triangleRadius * Mathf.Sqrt(3) / 2);
            c = new Vector3(-triangleRadius / 2, 0, triangleRadius * Mathf.Sqrt(3) / 2);

            a = transform.TransformPoint(a);
            b = transform.TransformPoint(b);
            c = transform.TransformPoint(c);

            Vector3 triCenter = (a + b + c) / 3.0f;
            targetObject.transform.position = triCenter;
        }

        void Update()
        {
            a.y = VRSL_RB._GetFloatData(ReadbackIndices[0]) * HeightMultiplier;
            b.y = VRSL_RB._GetFloatData(ReadbackIndices[1]) * HeightMultiplier;
            c.y = VRSL_RB._GetFloatData(ReadbackIndices[2]) * HeightMultiplier;

            normalDirection = Vector3.Normalize(Vector3.Cross(b - a, c - a));
            Quaternion rotation = Quaternion.FromToRotation(Vector3.up, normalDirection) * initialRotation;
            targetObject.transform.localRotation = rotation;

            Vector3 triCenter = (a + b + c) / 3.0f;
            targetObject.transform.position = initialPosition + new Vector3(0, triCenter.y, 0);
        }

        // void OnDrawGizmosSelected()
        // {
        //     Gizmos.color = Color.red;
        //     Gizmos.DrawLine(a, b);
        //     Gizmos.DrawLine(b, c);
        //     Gizmos.DrawLine(c, a);

        //     Gizmos.color = Color.blue;
        //     Gizmos.DrawWireSphere(a, 0.1f);
        //     Gizmos.DrawWireSphere(b, 0.1f);
        //     Gizmos.DrawWireSphere(c, 0.1f);
        // }
    }
}