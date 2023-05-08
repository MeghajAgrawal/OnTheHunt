using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    // Start is called before the first frame update
    public Transform target;
    public Vector3 offset;
    public float smoothFactor;
    public static bool ismenu;
    void Start()
    {
        ismenu = false;
    }

    // Update is called once per frame
    void FixedUpdate()
    {
        Vector3 targetposition = target.position + offset;
        Vector3 smoothPosition = Vector3.Lerp(transform.position, targetposition, smoothFactor * Time.deltaTime);
        transform.position = targetposition;
    }
}
