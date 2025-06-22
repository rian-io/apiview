// src/services/ApiService.ts
import type { ApiInfo, ProcessedFileData } from '../types';

export async function fetchApiInfos(): Promise<ApiInfo[]> {
    const res = await fetch('/api/v1/view');
    if (!res.ok) throw new Error(await res.text() || 'Failed to load files');
    return res.json();
}

export async function fetchProcessedFileData(slug: string): Promise<ProcessedFileData> {
    const res = await fetch(`/api/v1/view/${slug}`);
    if (!res.ok) throw new Error(await res.text() || 'Failed to load API details');
    return res.json();
}

export async function uploadApiFile(file: File): Promise<string> {
    const formData = new FormData();
    formData.append('file', file);
    const response = await fetch('api/v1/upload', {
        method: 'POST',
        body: formData,
    });
    if (!response.ok) {
        let errorMessage = 'Error uploading file. Please try again.';
        try {
            const errorData = await response.json();
            errorMessage = errorData.detail || errorMessage;
        } catch { }
        throw new Error(errorMessage);
    }
    return response.text();
}

export async function checkHealth(): Promise<boolean> {
    try {
        const res = await fetch('api/v1/health');
        return res.ok;
    } catch {
        return false;
    }
}
